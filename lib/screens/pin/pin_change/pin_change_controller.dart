import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinChangeController extends IOController {
  final pin = IOOtpModel(length: 4, isSecure: true);
  final confirm = IOOtpModel(length: 4, isSecure: true);

  final password = IOTextfieldModel(
    label: 'Нууц үгээ оруулна уу',
    validators: [ValidatorType.password],
    keyboardType: TextInputType.visiblePassword,
    isSecure: true,
  );

  final next = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
    isExpanded: true,
  ).obs;

  String get titleText => user.value.hasPincode
      ? 'Гүйлгээний нууц үг солих'
      : 'Гүйлгээний нууц үг үүсгэх';

  @override
  void onInit() {
    super.onInit();
    pin.controller.addListener(checkValidation);
    confirm.controller.addListener(checkValidation);
    password.status.addListener(checkValidation);
  }

  void checkValidation() {
    next.update((val) {
      val?.isEnabled = pin.isValid &&
          confirm.isValid &&
          password.isValid &&
          pin.value == confirm.value;
    });
  }

  Future onChange() async {
    isLoading.value = true;
    next.update((val) {
      val?.isLoading = true;
    });

    final response = await UserApi().changePin(
      pin: pin.value,
      password: password.value,
    );

    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      SessionManager.shared.getUser();
      await AppRoute.toSuccess(
        title: 'Гүйлгээний нууц үг амжилттай солигдлоо',
        description:
            'Та цаашид энэ гүйлгээний нууц үгээ ашиглан гүйлгээ хийгээрэй',
      );
      Get.back(result: pin.value);
    } else {
      showError(text: response.message);
    }
  }
}

enum PinChangeType { create, change }
