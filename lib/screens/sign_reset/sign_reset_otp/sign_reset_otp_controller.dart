import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignResetOtpController extends IOController {
  final SignResetModel model;
  final otp = IOOtpModel(length: 4);
  final timer = IOOtpTimerModel();
  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
    isExpanded: true,
  ).obs;
  String token = '';

  SignResetOtpController({
    required this.model,
  });

  @override
  void onInit() {
    super.onInit();
    otp.controller.addListener(() {
      next.update((val) {
        val?.isEnabled = otp.isValid;
      });
    });
    sendOtp();
  }

  Future sendOtp() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;

    final response = await UserApi().sendOtp(
      phone: model.phone,
      type: 'forgot-password',
    );

    isLoading.value = false;

    if (response.isSuccess) {
      token = response.data['token'].stringValue;
      timer.startTimer();
      otp.controller.clear();
      otp.focus.requestFocus();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future checkOtp() async {
    Get.focusScope?.unfocus();

    isLoading.value = true;
    next.update((val) {
      val?.isLoading = true;
    });

    final response = await UserApi().checkOtp(
      phoneNumber: model.phone,
      otp: otp.value,
      token: token,
    );

    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      model.otp = otp.value;
      model.token = token;
      AuthRoute.toSignResetPassword(model: model);
    } else {
      showError(text: response.message);
    }
  }
}
