import 'dart:convert';

import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignUpOtpController extends IOController {
  final model = Get.arguments as SignUpModel;

  final otp = IOOtpModel(length: 4);
  final timer = IOOtpTimerModel();

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
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
      phone: model.phone,
      type: 'register',
    );

    isLoading.value = false;

    if (response.isSuccess) {
      model.otpToken = response.data['token'].stringValue;
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
      token: model.otpToken,
    );

    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      Get.focusScope?.unfocus();
      checkDan();
    } else {
      showError(text: response.message);
    }
  }

  Future checkDan() async {
    final result = await AuthRoute.toSignUpDan();
    if (result == null) return;

    timer.endTimer();

    final info = jsonDecode(result['info'].toString()) as Map<String, dynamic>;
    model.info = info;

    if (result.exist('form')) {
      final fields = result['form']
          .listValue
          .map((e) => SignUpInfoModel.fromJson(e))
          .toList();
      model.fields = fields;
      AuthRoute.toSignUpInfo(model);
    } else {
      AuthRoute.toSignUpPassword(model);
    }
  }
}
