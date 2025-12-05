import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignUpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpPageController(), fenix: true);
    Get.lazyPut(() => SignUpPhoneController(), fenix: true);
    Get.lazyPut(() => SignUpOtpController(), fenix: true);
    Get.lazyPut(() => SignUpPasswordController(), fenix: true);
    Get.lazyPut(() => SignUpInfoController(), fenix: true);
  }
}
