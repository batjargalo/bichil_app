import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePhoneNumberController extends IOController {
  final current = IOTextfieldModel(
    label: 'Одоогийн утасны дугаар',
    isEnabled: false,
  );

  final phone = IOTextfieldModel(
    label: 'Утасны дугаараа оруулна уу',
    maxLength: 8,
    validators: [ValidatorType.phone],
    keyboardType: TextInputType.phone,
  );

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    current.setData(user.value.phone);
    phone.status.addListener(() {
      next.update((val) {
        val?.isEnabled = phone.isValid;
      });
    });
  }

  void onTapNext() async {
    Get.focusScope?.unfocus();

    isLoading.value = true;
    next.update((val) {
      val?.isLoading = true;
    });

    final response = await UserApi().sendOtp(
      phone: phone.value,
      type: 'change-phone',
    );

    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      final otpToken = response.data['token'].stringValue;

      MenuRoute.toChangePhoneOtp(
        phone: phone.value,
        otpToken: otpToken,
      );
    } else {
      showError(text: response.message);
    }
  }
}
