import 'package:bichil/library/library.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChangeEmailController extends IOController {
  final email = IOTextfieldModel(
    label: 'Имэйл хаяг',
    validators: [ValidatorType.email],
    keyboardType: TextInputType.emailAddress,
  );

  final save = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    email.status.addListener(checkValidation);
    email.setData(HelperManager.user.email);
  }

  @override
  void onClose() {
    email.status.removeListener(checkValidation);
    super.onClose();
  }

  void checkValidation() {
    save.update((val) => val?.isEnabled = email.isValid);
  }

  Future onTapSave() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;

    final response = await UserApi().changeEmail(email: email.value);

    isLoading.value = false;

    if (response.isSuccess) {
      await SessionManager.shared.getUser();
      Get.back(result: true);
    } else {
      showError(text: response.message);
    }
  }
}
