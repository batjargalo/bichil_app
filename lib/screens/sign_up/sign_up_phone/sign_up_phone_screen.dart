import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPhoneScreen extends GetView<SignUpPhoneController> {
  const SignUpPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Бүртгүүлэх',
        ),
        body: AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Та утасны дугаараа оруулна уу.',
                    style: IOStyles.h6,
                  ),
                  const SizedBox(height: 32),
                  IOTextfieldWidget(
                    model: controller.phone,
                  ),
                  const Spacer(),
                  IOButtonWidget(
                    model: controller.next.value,
                    onPressed: controller.onTapNext,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
