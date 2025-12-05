import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class SavingDetailController extends IOController {
  final detail = SavingDetailModel.fromJson(JSON.nil).obs;

  List<SavingDetailAction> get action1 => [
        SavingDetailAction.contract,
        SavingDetailAction.changeName,
        SavingDetailAction.statement,
        SavingDetailAction.calculator,
        if (detail.value.blockBal <= 0) SavingDetailAction.cashout,
      ];

  List<SavingDetailAction> get action2 => [
        SavingDetailAction.loan,
        SavingDetailAction.create,
      ];

  SavingDetailController({required SavingDetailModel info}) {
    detail.value = info;
  }

  Future getInfo() async {
    isInitialLoading.value = true;
    final response = await SavingApi().getSavingFullInfo(
      code: detail.value.accountNumber,
    );
    isInitialLoading.value = false;

    if (response.isSuccess) {
      detail.value = SavingDetailModel.fromJson(response.data);
    }
  }

  void onTapAction(SavingDetailAction action) {
    switch (action) {
      case SavingDetailAction.changeName:
        SavingRoute.toChangeName(saving: detail.value);
        break;
      case SavingDetailAction.contract:
        SavingRoute.toCreateContract(
          type: SavingCreateContractType.saving,
          item: null,
          code: detail.value.accountNumber,
        );
        break;
      case SavingDetailAction.statement:
        SavingRoute.toStatement(code: detail.value.accountNumber);
        break;
      case SavingDetailAction.calculator:
        SavingRoute.toCalculatorForm(hasAppBar: true);
        break;
      case SavingDetailAction.cashout:
        final result = SessionManager.shared.checkBankAccount();
        if (result == false) return;
        onCashout();
        break;
      case SavingDetailAction.loan:
        final result = SessionManager.shared.checkBankAccount();
        if (result == false) return;
        LoanRoute.toCreateSavingAmount(saving: detail.value);
        break;
      case SavingDetailAction.create:
        SavingRoute.toCreateCondition();
        break;
    }
  }

  Future onCashout() async {
    final result = await const SavingCloseSheet().show();
    if (result == null) return;

    final model = SavingCloseModel();
    model.type = result;
    model.saving = detail.value;
    switch (result) {
      case SavingCloseType.deposite:
        final response = await SavingApi().getSavingCondition();
        if (response.isSuccess) {
          model.minimumAmount =
              response.data['minimum_withdrawal_amount'].ddoubleValue;
          if (model.minimumAmount <= detail.value.availBal) {
            SavingRoute.toDeposite(model: model);
          } else {
            showError(text: 'Та итгэлцлээс хэсэгчилж авах боломжгүй байна');
          }
        } else {
          showError(text: response.message);
        }

        break;
      case SavingCloseType.close:
        if (detail.value.blockBal == 0) {
          model.closeAmount = detail.value.balance;
          SavingRoute.toCloseConfirm(model: model);
        } else {
          showError(text: 'Итгэлцэл хаах боломжгүй байна');
        }

        break;
    }
  }
}

enum SavingDetailAction {
  changeName(title: 'Итгэлцлийн нэр солих'),
  contract(title: 'Итгэлцлийн гэрээ харах'),
  statement(title: 'Хуулга'),
  calculator(title: 'Тооцоолуур'),
  cashout(title: 'Итгэлцлээс зарлага гаргах'),
  loan(title: 'Итгэлцэл барьцаалсан зээл авах'),
  create(title: 'Итгэлцэл нээх');

  const SavingDetailAction({required this.title});

  final String title;
}
