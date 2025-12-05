import 'package:bichil/library/library.dart';
import 'package:get/get.dart';

class ChangePhoneOtpController extends IOController {
  final String phone;
  String otpToken;

  final otp = IOOtpModel(length: 4);
  final timer = IOOtpTimerModel();

  ChangePhoneOtpController({
    required this.phone,
    required this.otpToken,
  });

  final next = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
    isExpanded: true,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    otp.controller.addListener(() {
      next.update((val) {
        val?.isEnabled = otp.isValid;
      });
    });
    timer.startTimer();
    otp.controller.clear();
    otp.focus.requestFocus();
  }

  Future sendOtp() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;

    final response = await UserApi().sendOtp(
      phone: phone,
      type: 'change-phone',
    );

    isLoading.value = false;

    if (response.isSuccess) {
      otpToken = response.data['token'].stringValue;
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
      phoneNumber: phone,
      otp: otp.value,
      token: otpToken,
    );

    if (response.isSuccess) {
      changePhone();
    } else {
      stopLoading();
      showError(text: response.message);
    }
  }

  Future changePhone() async {
    final response = await UserApi().changePhone(
      phone: phone,
      token: otpToken,
    );

    stopLoading();

    if (response.isSuccess) {
      await AppRoute.toSuccess(
        title: 'Амжилттай',
        description: 'Утасны дугаар амжилттай солигдлоо.',
      );
      Get.until((route) => route.isFirst);
      SessionManager.shared.getUser();
    } else {
      showError(text: response.message);
    }
  }

  void stopLoading() {
    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });
  }
}
