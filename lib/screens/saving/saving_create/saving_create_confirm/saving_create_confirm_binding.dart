import 'package:bichil/screens/saving/saving_create/saving_create.dart';
import 'package:get/get.dart';

class SavingCreateConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingCreateConfirmController());
  }
}
