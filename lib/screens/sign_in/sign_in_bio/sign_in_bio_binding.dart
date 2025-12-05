import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignInBioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInBioController());
    Get.lazyPut(() => MenuLeftController());
  }
}
