import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPasswordController extends IOController {
  final model = Get.arguments as SignUpModel;
  final passwordField = IOTextfieldModel(
    label: 'Нууц үг',
    keyboardType: TextInputType.visiblePassword,
    isSecure: true,
  );

  final passwordConfirmField = IOTextfieldModel(
    label: 'Нууц үгээ давтах ',
    keyboardType: TextInputType.visiblePassword,
    isSecure: true,
  );

  final back = IOButtonModel(
    label: 'Буцах',
    type: IOButtonType.secondary,
    size: IOButtonSize.medium,
  );

  final nextButton = IOButtonModel(
    label: 'Бүртгүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  final hasUppercase = false.obs;
  final hasDigits = false.obs;
  final hasLowercase = false.obs;
  final hasMinLength = false.obs;
  final hasSpecialCharacters = false.obs;
  final isPasswordMatch = false.obs;

  @override
  void onInit() {
    super.onInit();
    passwordField.controller.addListener(checkValidation);
    passwordConfirmField.controller.addListener(checkValidation);
  }

  void checkValidation() {
    isPasswordMatch.value = passwordField.value == passwordConfirmField.value;
    hasMinLength.value = passwordField.value.length > 7;
    hasUppercase.value = passwordField.value.contains(RegExp(r'[A-Z]'));
    hasLowercase.value = passwordField.value.contains(RegExp(r'[a-z]'));
    hasDigits.value = passwordField.value.contains(RegExp(r'[0-9]'));

    nextButton.update((val) {
      val?.isEnabled = passwordField.value.isNotEmpty &&
          passwordField.value.isNotEmpty &&
          hasMinLength.value &&
          hasUppercase.value &&
          hasLowercase.value &&
          hasDigits.value &&
          isPasswordMatch.value;
    });
  }

  void onNext() {
    Get.focusScope?.unfocus();
    model.password = passwordField.value;
    onRegister();
  }

  Future onRegister() async {
    isLoading.value = true;
    nextButton.update((val) {
      val?.isLoading = true;
    });

    final data = model.info;
    data['phone'] = model.phone;
    data['otp_token'] = model.otpToken;
    data['password'] = model.password;

    final response = await UserApi().register(data: data);

    isLoading.value = false;
    nextButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      await AppRoute.toSuccess(
        title: 'Бүртгэл амжилттай үүслээ',
        description: 'Та шинэ бүртгэлээ ашиглан нэвтрэх боломжтой',
      );
      Get.until((route) => route.isFirst);
    } else {
      showError(text: response.message);
    }
  }
}
