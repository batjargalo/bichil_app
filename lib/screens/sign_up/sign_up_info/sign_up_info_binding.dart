import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignUpInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpInfoController());
  }
}
