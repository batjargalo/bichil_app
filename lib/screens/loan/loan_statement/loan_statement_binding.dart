import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanStatementBinding extends Bindings {
  final LoanInfoModel loan;

  LoanStatementBinding({required this.loan});

  @override
  void dependencies() {
    Get.lazyPut(() => LoanStatementController(loan: loan));
  }
}
