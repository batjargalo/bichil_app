import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpPhoneController extends IOController {
  final model = SignUpModel();

  final phone = IOTextfieldModel(
    label: 'Утасны дугаар',
    validators: [ValidatorType.phone],
    keyboardType: TextInputType.phone,
    maxLength: 8,
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
      type: 'register',
    );

    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      model.otpToken = response.data['token'].stringValue;
      model.phone = phone.value;
      AuthRoute.toSignUpOtp(model);
    } else {
      showError(text: response.message);
    }
  }
}
