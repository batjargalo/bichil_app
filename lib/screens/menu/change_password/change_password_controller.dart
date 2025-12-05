import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends IOController {
  final oldPassword = IOTextfieldModel(
    label: 'Хуучин нууц үг',
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.visiblePassword,
    isSecure: true,
  );

  final password = IOTextfieldModel(
    label: 'Шинэ нууц үг',
    validators: [ValidatorType.password],
    keyboardType: TextInputType.visiblePassword,
    isSecure: true,
  );
  final confirm = IOTextfieldModel(
    label: 'Шинэ нууц үг давтах',
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

  @override
  void onInit() {
    super.onInit();
    oldPassword.status.addListener(checkValidation);
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
      button?.isEnabled = oldPassword.isValid &&
          hasMinLength.value &&
          hasUppercase.value &&
          hasLowercase.value &&
          hasDigits.value &&
          isPasswordMatch.value;
    });
  }

  Future changePassword() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    next.update((val) {
      val?.isLoading = true;
    });

    final response = await UserApi().changePassword(
      old: oldPassword.value,
      newPass: password.value,
    );

    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      //Biometric устгах хэрэгтэй
      await UserStoreManager.shared.write(kBiometricWithUser, false);

      await AppRoute.toSuccess(
        title: 'Нууц үг амжилттай солигдлоо.',
        description: 'Та цаашид шинэ нууц үгээ ашиглан нэвтрэх боломжтой',
      );
      Get.until((route) => route.isFirst);
    } else {
      showError(text: response.message);
    }
  }
}
