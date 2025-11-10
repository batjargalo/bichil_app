import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinChangeScreen extends GetView<PinChangeController> {
  const PinChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: controller.titleText,
        ),
        body: AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: GestureDetector(
            onTap: Get.focusScope?.unfocus,
            child: SizedBox.expand(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Цаашид ашиглах гүйлгээний нууц үгээ оруулна уу',
                      style: IOStyles.body2Regular.copyWith(
                        color: IOColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    IOOtpWidget(model: controller.pin),
                    const SizedBox(height: 32),
                    Text(
                      'Гүйлгээний нууц үгээ давтаж оруулна уу',
                      style: IOStyles.body2Regular.copyWith(
                        color: IOColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    IOOtpWidget(model: controller.confirm),
                    const SizedBox(height: 32),
                    Text(
                      'Нэвтрэх нууц үгээ оруулна уу',
                      style: IOStyles.body2Regular.copyWith(
                        color: IOColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    IOTextfieldWidget(model: controller.password),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          child: IOButtonWidget(
            model: controller.next.value,
            onPressed: controller.onChange,
          ),
        ),
      ),
    );
  }
}
