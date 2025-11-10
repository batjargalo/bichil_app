import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPasswordScreen extends GetView<SignUpPasswordController> {
  const SignUpPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Бүртгүүлэх',
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  IOTextfieldWidget(
                    model: controller.passwordField,
                  ),
                  const SizedBox(height: 16),
                  IOTextfieldWidget(
                    model: controller.passwordConfirmField,
                  ),
                  const SizedBox(height: 16),
                  SignUpPasswordValidationWidget(
                    text: 'Нууц үг 8-с дээш тэмдэгттэй байх',
                    isValid: controller.hasMinLength.value,
                  ),
                  SignUpPasswordValidationWidget(
                    text: 'Том, жижиг үсэг орсон байх',
                    isValid: controller.hasUppercase.value,
                  ),
                  SignUpPasswordValidationWidget(
                    text: 'Тоо орсон байх',
                    isValid: controller.hasDigits.value,
                  ),
                  SignUpPasswordValidationWidget(
                    text: '2 нууц үг таарч байх',
                    isValid: controller.isPasswordMatch.value,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IOBottomNavigationBar(
                child: IOButtonWidget(
                  model: controller.nextButton.value,
                  onPressed: controller.onNext,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
