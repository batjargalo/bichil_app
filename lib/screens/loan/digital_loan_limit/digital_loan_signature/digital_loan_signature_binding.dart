import 'package:bichil/screens/loan/digital_loan_limit/digital_loan_signature/digital_loan_signature_controller.dart';
import 'package:get/get.dart';

class DigitalLoanSignatureBinding extends Bindings {
  DigitalLoanSignatureBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => DigitalLoanSignatureController());
  }
}
