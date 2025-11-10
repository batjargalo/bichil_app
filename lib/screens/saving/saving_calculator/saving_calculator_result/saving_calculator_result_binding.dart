import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCalculatorResultBinding extends Bindings {
  final SavingCalculatorModel model;
  SavingCalculatorResultBinding({required this.model});
  @override
  void dependencies() {
    Get.lazyPut(
      () => SavingCalculatorResultController(model: model),
    );
  }
}
