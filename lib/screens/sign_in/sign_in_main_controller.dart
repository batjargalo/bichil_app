import 'package:bichil/library/library.dart';
import 'package:get/get.dart';

class SignInMainController extends IOController {
  final isCheckedBiometric = false.obs;

  final signInButton = IOButtonModel(
    label: 'Нэвтрэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isExpanded: true,
    isEnabled: false,
  ).obs;

  void stopLoading() {
    isLoading.value = false;
    signInButton.update((val) {
      val?.isLoading = false;
    });
  }

  Future onSignIn({required String phone, required String pass}) async {
    isLoading.value = true;
    signInButton.update((val) {
      val?.isLoading = true;
    });

    final response = await UserApi().login(
      username: phone,
      password: pass,
    );

    if (response.isSuccess) {
      final token = TokenModel.fromJson(response.data);
      await UserStoreManager.shared.write(kToken, token.toMap());
      await getUserInfo(phone: phone, pass: pass);
    } else {
      stopLoading();
      showError(text: response.message);
    }
  }

  Future getUserInfo({required String phone, required String pass}) async {
    final response = await UserApi().getUserInfo();
    stopLoading();
    if (response.isSuccess) {
      final user = UserModel.fromJson(response.data);
      await UserStoreManager.shared.write(kUser, user.toMap());
      await checkBiometric(phone: phone, pass: pass);
      IOPages.toHome();
      registerDevice();
      SessionManager.shared.eventChanged();
    } else {
      await UserStoreManager.shared.deleteStore();
      showError(text: response.message);
    }
  }

  Future checkBiometric({required String phone, required String pass}) async {
    if (!isCheckedBiometric.value) return;

    final result = await BiometricManager.shared.checkAuthenticate();

    if (result.success) {
      final model = BiometricModel(
        username: HelperManager.user.firstName,
        phone: phone,
        password: pass,
      );
      await BiometricManager.shared.saveBiometric(model);
    } else {
      // print(result.errorMessage);
    }
  }

  Future registerDevice() async {
    await UserApi().registerDevice();
  }
}
