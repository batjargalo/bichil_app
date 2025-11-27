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

  List<LoanDetailActionModel> get pledge => [LoanDetailActionPledgeModel(title: 'Барьцаа хөрөнгө')];

  LoanDetailController({required this.loan});

  Future getPledge() async {
    final response = await LoanApi().getPledgeList(code: loan.acntCode);
    if (response.isSuccess) {
      pledgeList.value = response.data.listValue.map((e) => LoanPledgeModel.fromJson(e)).toList();
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
