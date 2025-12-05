import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingNameScreen extends GetView<SavingNameController> {
  const SavingNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Нэр солих',
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IOTextfieldWidget(model: controller.name),
                const Spacer(),
                IOButtonWidget(
                  model: controller.button.value,
                  onPressed: controller.changeName,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
