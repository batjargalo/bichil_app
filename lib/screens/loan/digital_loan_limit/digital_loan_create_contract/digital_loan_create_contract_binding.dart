import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class DigitalLoanContractBinding extends Bindings {
  final DigitalLoanLimitModel? item;
  final String? code;
  DigitalLoanContractBinding({required this.item, required this.code});

  @override
  void dependencies() {
    Get.lazyPut(() => DigitalLoanContractController(item: item, code: code));
  }
}
