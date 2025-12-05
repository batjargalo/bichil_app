import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class ChangeEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeEmailController());
  }
}
