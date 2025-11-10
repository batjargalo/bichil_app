import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignResetPasswordScreen extends GetView<SignResetPasswordController> {
  const SignResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Нууц үг мартсан',
      ),
      body: Obx(
        () => Stack(
          children: [
            AbsorbPointer(
              absorbing: controller.isLoading.value,
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Та шинээр нэвтрэх нууц үг үүсгэнэ үү.',
                        style: IOStyles.h6.copyWith(
                          color: IOColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      IOTextfieldWidget(model: controller.password),
                      const SizedBox(height: 16),
                      IOTextfieldWidget(model: controller.confirm),
                      const SizedBox(height: 16),
                      PasswordValidationWidget(
                        text: 'Нууц үг 8-с дээш тэмдэгттэй байх',
                        isValid: controller.hasMinLength.value,
                      ),
                      PasswordValidationWidget(
                        text: 'Том, жижиг үсэг орсон байх',
                        isValid: controller.hasUppercase.value,
                      ),
                      PasswordValidationWidget(
                        text: 'Тоо орсон байх',
                        isValid: controller.hasDigits.value,
                      ),
                      PasswordValidationWidget(
                        text: 'Давтсан нууц үг таарч байх',
                        isValid: controller.isPasswordMatch.value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IOButtonWidget(
                    model: controller.next.value,
                    onPressed: controller.resetPassword,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
