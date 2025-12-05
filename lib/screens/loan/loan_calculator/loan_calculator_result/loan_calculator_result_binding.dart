import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCalculatorResultBinding extends Bindings {
  final LoanCalculatorModel model;

  LoanCalculatorResultBinding({required this.model});

  @override
  void dependencies() {
    Get.lazyPut(
      () => LoanCalculatorResultController(model: model),
    );
  }
}
