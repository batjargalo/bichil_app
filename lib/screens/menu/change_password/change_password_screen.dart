import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: MenuTabItemType.changePassword.title,
        ),
        body: AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: GestureDetector(
            onTap: Get.focusScope?.unfocus,
            child: SizedBox.expand(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    IOTextfieldWidget(model: controller.oldPassword),
                    const SizedBox(height: 16),
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
                      text: '2 нууц үг таарч байх',
                      isValid: controller.isPasswordMatch.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          child: IOButtonWidget(
            model: controller.next.value,
            onPressed: controller.changePassword,
          ),
        ),
      ),
    );
  }
}
