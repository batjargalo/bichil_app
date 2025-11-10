import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignUpDanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpDanController());
  }
}
