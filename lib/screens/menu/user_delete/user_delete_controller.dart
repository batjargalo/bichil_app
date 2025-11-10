import 'package:bichil/library/library.dart';
import 'package:get/get.dart';

class UserDeleteController extends IOController {
  final password = IOTextfieldModel(
    label: 'Нэвтрэх нууц үг',
    validators: [ValidatorType.password],
    isSecure: true,
    autofocus: true,
  );

  final deleteButton = IOButtonModel(
    label: 'Устгах',
    type: IOButtonType.secondary,
    size: IOButtonSize.medium,
    enabledBackgroundColor: IOColors.errorSecondary,
    enabledForegroundColor: IOColors.errorPrimary,
    prefixIcon: 'trash.svg',
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    password.status.addListener(() {
      deleteButton.update((val) {
        val?.isEnabled = password.isValid;
      });
    });
  }

  Future onDeleteAccount() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    deleteButton.update((val) {
      val?.isLoading = true;
    });

    final response = await UserApi().delete(password: password.value);

    isLoading.value = false;
    deleteButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      await SessionManager.shared.logout();
    } else {
      showError(text: response.message);
    }
  }
}
