import 'package:bichil/screens/loan/digital_loan_limit/digital_loan_create_contract/digital_loan_create_contract_controller.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class TabBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabBarController());
    Get.lazyPut(() => GoldTabController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => LoanTabController());
    Get.lazyPut(() => SavingTabController());
    Get.lazyPut(() => MenuTabController());
    Get.lazyPut(() => LoanHomeController());
    Get.lazyPut(() => LoanProductController());
    Get.lazyPut(() => DigitalLoanContractController(item: null, code: ''));
  }
}
