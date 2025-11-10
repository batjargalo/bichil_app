import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class AuthRoute {
  static toTabBar() {
    Get.offAll(
      () => const TabBarScreen(),
      binding: TabBarBinding(),
    );
  }

  static toSignResetPhone() {
    Get.to(
      () => const SignResetPhoneScreen(),
      binding: SignResetPhoneBinding(),
    );
  }

  static toSignResetOtp({required SignResetModel model}) {
    Get.to(
      () => const SignResetOtpScreen(),
      binding: SignResetOtpBinding(model: model),
    );
  }

  static toSignResetPassword({required SignResetModel model}) {
    Get.to(
      () => const SignResetPasswordScreen(),
      binding: SignResetPasswordBinding(model: model),
    );
  }

  static toSignUpPhone() {
    Get.to(
      () => const SignUpPhoneScreen(),
      binding: SignUpPhoneBinding(),
    );
  }

  static toSignUpOtp(SignUpModel model) {
    Get.to(
      () => const SignUpOtpScreen(),
      binding: SignUpOtpBinding(),
      arguments: model,
    );
  }

  static toSignUpInfo(SignUpModel model) {
    Get.to(
      () => const SignUpInfoScreen(),
      binding: SignUpInfoBinding(),
      arguments: model,
    );
  }

  static toSignUpPassword(SignUpModel model) {
    Get.to(
      () => const SignUpPasswordScreen(),
      binding: SignUpPasswordBinding(),
      arguments: model,
    );
  }

  static Future<JSON?>? toSignUpDan() {
    return Get.to(
      () => const SignUpDanScreen(),
      binding: SignUpDanBinding(),
    );
  }
}
