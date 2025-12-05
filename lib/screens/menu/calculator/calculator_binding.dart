import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculatorController());
    Get.lazyPut(() => LoanCalculatorFormController(hasAppBar: false));
    Get.lazyPut(() => SavingCalculatorFormController(hasAppBar: false));
  }
}
