import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class LoanDetailController extends IOController {
  final LoanInfoModel loan;
  final pledgeList = <LoanPledgeModel>[].obs;
  List<LoanDetailActionModel> get actions => [
    if (loan.canTakeLoan) LoanDetailActionGetModel(title: 'Зээл авах'),
    // LoanDetailActionCardModel(title: 'Карт холбох'),
    LoanDetailActionRepaymentModel(title: 'Эргэн төлөлтийн хуваарь'),
    LoanDetailActionStatementModel(title: 'Хуулга'),
    // LoanDetailActionCalculateModel(title: 'Тооцоолуур'),
  ];

  List<LoanDetailActionModel> get pledge => [
    LoanDetailActionPledgeModel(title: 'Барьцаа хөрөнгө'),
  ];

  LoanDetailController({required this.loan});

  @override
  void onInit() {
    super.onInit();
    getPledge();
  }

  Future getPledge() async {
    try {
      isLoading.value = true;
      final response = await LoanApi().getCollateralInfo(
        accountCode: loan.acntCode,
      );
      final payload = response.data.listValue.isNotEmpty
          ? response.data.listValue
          : response.json.listValue;

      pledgeList.clear();
      if (payload.isEmpty) {
        return;
      }

      pledgeList.addAll(
        payload
            .map((item) => LoanPledgeModel.fromJson(item))
            .toList(growable: false),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onTapAction(LoanDetailActionModel action) {
    switch (action) {
      case LoanDetailActionGetModel():
        final result = SessionManager.shared.checkBankAccount();
        if (result == false) return;
        LoanRoute.toRecreateAmount(item: loan);
        break;
      case LoanDetailActionCardModel():
        break;
      case LoanDetailActionRepaymentModel():
        LoanRoute.toSchedule(loan: loan);
        break;
      case LoanDetailActionCalculateModel():
        LoanRoute.toCalculatorForm(loan: loan);
        break;
      case LoanDetailActionStatementModel():
        LoanRoute.toStatement(loan: loan);
        break;
      case LoanDetailActionPledgeModel():
        LoanRoute.toPledgeList(items: pledgeList.toList());
        break;
    }
  }
}
