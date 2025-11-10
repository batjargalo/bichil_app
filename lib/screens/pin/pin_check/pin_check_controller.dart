import 'package:bichil/library/library.dart';
import 'package:get/get.dart';

class PinCheckController extends IOController {
  final pin = IOOtpModel(length: 4, isSecure: true);

  String get forgetText =>
      user.value.hasPincode ? 'Нууц үг мартсан?' : 'Нууц үг үүсгэх';

  @override
  void onInit() {
    super.onInit();
    pin.controller.addListener(checkFilled);
  }

  void checkFilled() {
    if (pin.isValid) {
      onFilled();
    }
  }

  void onFilled() {
    Get.back(result: pin.value);
  }

  void onForgot() {
    MenuRoute.toChangePin();
  }
}
