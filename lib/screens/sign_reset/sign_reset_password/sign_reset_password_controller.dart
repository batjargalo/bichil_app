import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignResetPasswordController extends IOController {
  final SignResetModel model;
  final password = IOTextfieldModel(
    label: 'Шинэ нууц',
    validators: [ValidatorType.password],
    keyboardType: TextInputType.visiblePassword,
    isSecure: true,
  );
  final confirm = IOTextfieldModel(
    label: 'Нууц үг давтах',
    validators: [ValidatorType.password],
    keyboardType: TextInputType.visiblePassword,
    isSecure: true,
  );

  final next = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  final hasUppercase = false.obs;
  final hasDigits = false.obs;
  final hasLowercase = false.obs;
  final hasMinLength = false.obs;
  final isPasswordMatch = false.obs;

  SignResetPasswordController({
    required this.model,
  });

  @override
  void onInit() {
    super.onInit();
    password.controller.addListener(checkValidation);
    confirm.controller.addListener(checkValidation);
  }

  void checkValidation() {
    String passwordText = password.controller.text;
    String confirmText = confirm.controller.text;

    isPasswordMatch.value = passwordText == confirmText;
    hasMinLength.value = passwordText.length >= 8;
    hasUppercase.value = passwordText.contains(RegExp(r'[A-Z]'));
    hasLowercase.value = passwordText.contains(RegExp(r'[a-z]'));
    hasDigits.value = passwordText.contains(RegExp(r'[0-9]'));

    next.update((button) {
      button?.isEnabled = hasMinLength.value &&
          hasUppercase.value &&
          hasLowercase.value &&
          hasDigits.value &&
          isPasswordMatch.value;
    });
  }

  Future resetPassword() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    next.update((val) {
      val?.isLoading = true;
    });

    final response = await UserApi().resetPassword(
      phone: model.phone,
      password: password.value,
      token: model.token,
    );

    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      await AppRoute.toSuccess(
        title: 'Нууц үг амжилттай сэргээгдлээ',
        description: 'Та цаашид шинэ нууц үгээ ашиглан нэвтрэх боломжтой',
      );
      Get.until((route) => route.isFirst);
    } else {
      showError(text: response.message);
    }
  }
}
