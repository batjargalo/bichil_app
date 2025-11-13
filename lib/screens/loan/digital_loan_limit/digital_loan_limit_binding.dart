import 'package:bichil/screens/screens.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class DigitalLoanLimitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DigitalLoanLimitController());
  }
}
