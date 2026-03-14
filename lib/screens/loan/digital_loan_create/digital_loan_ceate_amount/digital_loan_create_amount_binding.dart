import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class DigitalLoanCreateAmountBinding extends Bindings {
  DigitalLoanCreateAmountBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => DigitalLoanCreateAmountController());
  }
}
