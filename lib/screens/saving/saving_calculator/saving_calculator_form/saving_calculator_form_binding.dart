import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCalculatorFormBinding extends Bindings {
  final bool hasAppBar;
  SavingCalculatorFormBinding({
    required this.hasAppBar,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => SavingCalculatorFormController(hasAppBar: hasAppBar),
    );
  }
}
