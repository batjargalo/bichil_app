import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCreateConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingCreateConditionController());
  }
}
