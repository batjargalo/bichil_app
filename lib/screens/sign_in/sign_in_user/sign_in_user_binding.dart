import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignInUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInUserController());
    Get.lazyPut(() => MenuLeftController());
  }
}
