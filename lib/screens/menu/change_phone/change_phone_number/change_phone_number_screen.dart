import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePhoneNumberScreen extends GetView<ChangePhoneNumberController> {
  const ChangePhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Утасны дугаар солих',
      ),
      body: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  IOTextfieldWidget(
                    model: controller.current,
                  ),
                  const SizedBox(height: 12),
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
