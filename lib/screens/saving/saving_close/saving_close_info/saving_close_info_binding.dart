import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCloseInfoBinding extends Bindings {
  final SavingCloseModel model;

  SavingCloseInfoBinding({required this.model});

  @override
  void dependencies() {
    Get.lazyPut(
      () => SavingCloseInfoController(model: model),
    );
  }
}
