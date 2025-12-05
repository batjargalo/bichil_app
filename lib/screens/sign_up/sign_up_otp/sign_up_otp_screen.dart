import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpOtpScreen extends GetView<SignUpOtpController> {
  const SignUpOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Бүртгүүлэх',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Танд ирсэн баталгаажуулах кодыг оруулна уу.',
                  style: IOStyles.h6,
                ),
                const SizedBox(height: 32),
                IOOtpWidget(model: controller.otp),
                const SizedBox(height: 16),
                IOOtpTimerWidget(
                  model: controller.timer,
                  onTap: controller.sendOtp,
                ),
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
