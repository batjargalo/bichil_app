import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeEmailScreen extends GetView<ChangeEmailController> {
  const ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(titleText: 'Имэйл хаяг солих'),
        body: AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: Get.focusScope?.unfocus,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IOTextfieldWidget(model: controller.email),
                  const SizedBox(height: 16),
                  const Spacer(),
                  IOButtonWidget(
                    model: controller.save.value,
                    onPressed: controller.onTapSave,
                  ),
                  SizedBox(height: Get.mediaQuery.padding.bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
