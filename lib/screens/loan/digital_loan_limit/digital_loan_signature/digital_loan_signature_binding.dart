import 'package:bichil/screens/loan/digital_loan_create/digital_loan_ceate_amount/models/digital_loan_create_model.dart';
import 'package:bichil/screens/loan/digital_loan_limit/digital_loan_signature/digital_loan_signature_controller.dart';
import 'package:get/get.dart';

class DigitalLoanSignatureBinding extends Bindings {
  final DigitalLoanCreateModel? item;
  DigitalLoanSignatureBinding({required this.item});

  @override
  void dependencies() {
    Get.lazyPut(() => DigitalLoanSignatureController(item: item));
  }
}
