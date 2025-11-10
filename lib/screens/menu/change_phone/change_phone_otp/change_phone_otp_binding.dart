import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class ChangePhoneOtpBinding extends Bindings {
  final String phone;
  final String otpToken;

  ChangePhoneOtpBinding({
    required this.phone,
    required this.otpToken,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => ChangePhoneOtpController(
        phone: phone,
        otpToken: otpToken,
      ),
    );
  }
}
