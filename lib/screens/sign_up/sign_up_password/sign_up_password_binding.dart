import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignUpPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpPasswordController());
  }
}
