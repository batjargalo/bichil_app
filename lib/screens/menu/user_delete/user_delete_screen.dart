import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDeleteScreen extends GetView<UserDeleteController> {
  const UserDeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Бүртгэл устгах',
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: AbsorbPointer(
            absorbing: controller.isLoading.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IOTextfieldWidget(
                  model: controller.password,
                ),
                const SizedBox(height: 16),
                IOButtonWidget(
                  model: controller.deleteButton.value,
                  onPressed: controller.onDeleteAccount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
