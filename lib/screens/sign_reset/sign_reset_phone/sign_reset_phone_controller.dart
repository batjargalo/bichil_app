import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignResetPhoneController extends IOController {
  final model = SignResetModel();
  final phone = IOTextfieldModel(
    label: 'Утасны дугаар',
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
    phone.status.addListener(() {
      next.update((val) {
        val?.isEnabled = phone.isValid;
      });
    });
  }

  void onTapNext() {
    Get.focusScope?.unfocus();
    model.phone = phone.value;
    AuthRoute.toSignResetOtp(model: model);
  }
}
