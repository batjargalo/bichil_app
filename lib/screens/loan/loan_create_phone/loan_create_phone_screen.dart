import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreatePhoneScreen extends GetView<LoanCreatePhoneController> {
  const LoanCreatePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Зээл',
        ),
        body: GestureDetector(
          onTap: Get.focusScope?.unfocus,
          child: SizedBox.expand(
            child: AbsorbPointer(
              absorbing: controller.isLoading.value,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IOTextfieldWidget(model: controller.amount),
                    const SizedBox(height: 24),
                    const Text(
                      'Барьцаалах дугаараа оруулна уу.',
                      style: IOStyles.body1SemiBold,
                    ),
                    const SizedBox(height: 12),
                    IOTextfieldWidget(model: controller.phone),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          backgroundColor: IOColors.backgroundPrimary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: IOColors.warningSecondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Та зөвхөн өөрийн өмчлөлийг барьцаалж зээл авах боломжтойг анхаарана уу.',
                  style: IOStyles.body2Regular.copyWith(
                    color: IOColors.warningPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              IOButtonWidget(
                onPressed: controller.onTapSend,
                model: controller.send.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
