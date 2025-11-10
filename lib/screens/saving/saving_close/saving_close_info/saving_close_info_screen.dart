import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingCloseInfoScreen extends GetView<SavingCloseInfoController> {
  const SavingCloseInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: controller.model.type.title,
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SavingCloseConditionWidget(
                        model: controller.model,
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: IOBottomNavigationBar(
          backgroundColor: IOColors.backgroundPrimary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IOGesture(
                onTap: controller.isChecked.toggle,
                child: IOCardBorderWidget(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      SizedBox.square(
                        dimension: 16,
                        child: IOCheckbox(
                          value: controller.isChecked.value,
                          onChanged: controller.isChecked.call,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Би дээрх нөхцөлүүдийг зөвшөөрч байна.',
                        style: IOStyles.caption1Regular,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              IOButtonWidget(
                model: controller.button.value,
                onPressed: controller.closeSaving,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
