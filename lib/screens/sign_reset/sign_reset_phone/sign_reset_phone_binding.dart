import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignResetPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignResetPhoneController());
  }
}
