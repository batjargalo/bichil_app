import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignResetPhoneScreen extends GetView<SignResetPhoneController> {
  const SignResetPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Нууц үг мартсан',
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Та утасны дугаараа\nоруулна уу.',
                  style: IOStyles.h6.copyWith(
                    color: IOColors.textPrimary,
                  ),
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
    );
  }
}
