import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeBankScreen extends GetView<ChangeBankController> {
  const ChangeBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Дансны дугаар',
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: GestureDetector(
                  onTap: Get.focusScope?.unfocus,
                  child: SizedBox.expand(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          IODropdownWidget.custom(
                            model: controller.accBank,
                            onTap: controller.onTapBanks,
                          ),
                          const SizedBox(height: 16),
                          IOTextfieldWidget(model: controller.accNumber),
                          const SizedBox(height: 16),
                          IOTextfieldWidget(model: controller.accName),
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: IOColors.brand50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Та өөрийн нэр дээрх дансны дугаарыг холбох боломжтой.',
                  style: IOStyles.caption1Regular,
                ),
              ),
              const SizedBox(height: 16),
              IOButtonWidget(
                model: controller.save.value,
                onPressed: controller.onTapSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
