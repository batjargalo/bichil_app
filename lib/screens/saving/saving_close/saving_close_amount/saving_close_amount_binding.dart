import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCloseAmountBinding extends Bindings {
  final SavingCloseModel model;
  SavingCloseAmountBinding({required this.model});

  @override
  void dependencies() {
    Get.lazyPut(
      () => SavingCloseAmountController(model: model),
    );
  }
}
