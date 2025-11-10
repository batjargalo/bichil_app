import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class LoanPayInfoBinding extends Bindings {
  final LoanInfoModel loan;
  LoanPayInfoBinding({required this.loan});

  @override
  void dependencies() {
    Get.lazyPut(() => LoanPayInfoController(loan: loan));
  }
}
