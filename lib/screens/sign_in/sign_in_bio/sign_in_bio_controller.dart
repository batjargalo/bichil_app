import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SignInBioController extends SignInMainController {
  final key = GlobalKey<ScaffoldState>();
  final bio = HelperManager.biometric;
  final newButton = IOButtonModel(
    label: 'Шинэ хэрэглэгчээр нэвтрэх',
    type: IOButtonType.textBrand,
    size: IOButtonSize.medium,
  );

  @override
  void onInit() {
    super.onInit();
    setData();
  }

  Future setData() async {
    final icon = await BiometricManager.shared.icon;
    signInButton.value = IOButtonModel(
      label: 'Нэвтрэх',
      type: IOButtonType.primary,
      size: IOButtonSize.medium,
      suffixIcon: icon,
    );
  }

  Future onTapSignIn() async {
    final response = await BiometricManager.shared.checkAuthenticate();
    if (response.success) {
      await UserStoreManager.shared.write(kBiometricWithUser, true);

      super.onSignIn(phone: bio.phone, pass: bio.password);
    } else {
      showError(text: response.errorMessage);
    }
  }

  Future onBack() async {
    await UserStoreManager.shared.write(kBiometricWithUser, false);
    await SessionManager.shared.logout();
  }

  void onTapMenu() {
    key.currentState!.openDrawer();
  }
}
