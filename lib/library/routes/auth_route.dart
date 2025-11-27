import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class AuthRoute {
  static void toTabBar() {
    Get.offAll(() => const TabBarScreen(), binding: TabBarBinding());
  }

  static void toSignResetPhone() {
    Get.to(() => const SignResetPhoneScreen(), binding: SignResetPhoneBinding());
  }

  static void toSignResetOtp({required SignResetModel model}) {
    Get.to(() => const SignResetOtpScreen(), binding: SignResetOtpBinding(model: model));
  }

  static void toSignResetPassword({required SignResetModel model}) {
    Get.to(() => const SignResetPasswordScreen(), binding: SignResetPasswordBinding(model: model));
  }

  static void toSignUpPhone() {
    Get.to(() => const SignUpPhoneScreen(), binding: SignUpPhoneBinding());
  }

  static void toSignUpOtp(SignUpModel model) {
    Get.to(() => const SignUpOtpScreen(), binding: SignUpOtpBinding(), arguments: model);
  }

  static void toSignUpInfo(SignUpModel model) {
    Get.to(() => const SignUpInfoScreen(), binding: SignUpInfoBinding(), arguments: model);
  }

  static void toSignUpPassword(SignUpModel model) {
    Get.to(() => const SignUpPasswordScreen(), binding: SignUpPasswordBinding(), arguments: model);
  }

  static Future<JSON?>? toSignUpDan() {
    return Get.to(() => const SignUpDanScreen(), binding: SignUpDanBinding());
  }
}
