import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignResetOtpScreen extends GetView<SignResetOtpController> {
  const SignResetOtpScreen({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Танд ирсэн баталгаажуулах кодыг оруулна уу.',
                  style: IOStyles.h6.copyWith(
                    color: IOColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 32),
                IOOtpWidget(model: controller.otp),
                const SizedBox(height: 16),
                IOOtpTimerWidget(model: controller.timer),
                const Spacer(),
                IOButtonWidget(
                  model: controller.next.value,
                  onPressed: controller.checkOtp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
