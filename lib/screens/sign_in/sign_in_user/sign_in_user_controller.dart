import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInUserController extends SignInMainController {
  final key = GlobalKey<ScaffoldState>();

  final phoneField = IOTextfieldModel(
    label: 'Утасны дугаар',
    validators: [ValidatorType.phone],
    maxLength: 8,
    keyboardType: TextInputType.phone,
  );
  final passField = IOTextfieldModel(
    label: 'Нууц үг',
    isSecure: true,
    validators: [ValidatorType.password],
    keyboardType: TextInputType.visiblePassword,
  );
  final homeButton = IOButtonModel(
    label: 'Бүртгэлгүй нэвтрэх',
    type: IOButtonType.secondary,
    size: IOButtonSize.medium,
  );
  final signUpButton = IOButtonModel(
    label: 'Бүртгүүлэх',
    type: IOButtonType.textBrand,
    size: IOButtonSize.medium,
    isExpanded: true,
    isEnabled: true,
  );

  @override
  void onInit() {
    super.onInit();
    phoneField.status.addListener(checkValidation);
    passField.status.addListener(checkValidation);
  }

  void checkValidation() {
    signInButton.update((val) {
      val?.isEnabled = phoneField.isValid && passField.isValid;
    });
  }

  void onTapMenu() {
    key.currentState!.openDrawer();
  }

  void onTapHome() {
    IOPages.toHome();
  }

  void onTapSignIn() {
    Get.focusScope?.unfocus();
    super.onSignIn(
      phone: phoneField.value,
      pass: passField.value,
    );
  }

  void onTapSignUp() {
    AuthRoute.toSignUpPhone();
  }

  void onTapReset() {
    AuthRoute.toSignResetPhone();
  }
}
