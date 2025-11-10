import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePhoneOtpScreen extends GetView<ChangePhoneOtpController> {
  const ChangePhoneOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Дугаар баталгаажуулалт',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Таны утасны дугаарт ирсэн 4 оронтой кодыг оруулан утасны дугаараа баталгаажуулна уу. ',
                  style: IOStyles.body2Regular.copyWith(
                    color: IOColors.textSecondary,
                  ),
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
