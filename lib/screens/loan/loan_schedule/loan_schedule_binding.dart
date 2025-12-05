import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanScheduleBinding extends Bindings {
  final LoanInfoModel loan;

  LoanScheduleBinding({required this.loan});

  @override
  void dependencies() {
    Get.lazyPut(() => LoanScheduleController(loan: loan));
  }
}
