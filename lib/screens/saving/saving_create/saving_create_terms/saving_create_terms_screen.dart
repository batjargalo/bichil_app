import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingCreateTermsScreen extends GetView<SavingCreateTermsController> {
  const SavingCreateTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Итгэлцэл нээх',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SavingCreateConfirmButtonWidget(
                title: controller.contract.title,
                onTap: controller.onTapContract,
              ),
              const SizedBox(height: 16),
              SavingCreateConfirmButtonWidget(
                title: 'Үйлчилгээний нөхцөл',
                onTap: controller.onTapTerms,
              ),
            ],
          ),
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          backgroundColor: IOColors.backgroundPrimary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IOGesture(
                onTap: controller.accepted.toggle,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: IOColors.brand100,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox.square(
                        dimension: 16,
                        child: IOCheckbox(
                          value: controller.accepted.value,
                          onChanged: controller.accepted.call,
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
              Row(
                children: [
                  Expanded(
                    child: IOButtonWidget(
                      model: controller.next.value,
                      onPressed: controller.onTapNext,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
