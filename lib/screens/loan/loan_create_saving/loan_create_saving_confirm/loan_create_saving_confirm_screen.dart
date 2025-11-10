import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateSavingConfirmScreen
    extends GetView<LoanCreateSavingConfirmController> {
  const LoanCreateSavingConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.isLoading.value,
        child: IOScaffold(
          appBar: IOAppBar(
            titleText: 'Итгэлцэл барьцаалсан зээл',
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IOCardBorderWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'Зээлийн хэмжээ',
                          style: IOStyles.body2Semibold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          controller.create.amount.toCurrency(),
                          style: IOStyles.h3.copyWith(
                            color: IOColors.brand500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1, thickness: 1),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RowWidget(
                              title: 'Хугацаа',
                              value:
                                  controller.saving.closeDate.toFormattedString(
                                format: 'yyyy/MM/dd',
                              ),
                            ),
                            const SizedBox(height: 16),
                            RowWidget(
                              title: 'Хүү',
                              value:
                                  '${controller.create.rate.toStringAsFixed(2)}%',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SavingCreateConfirmButtonWidget(
                  title: controller.contract.title,
                  onTap: controller.onTapContract,
                ),
                const SizedBox(height: 16),
                SavingCreateConfirmButtonWidget(
                  title: 'Үйлчилгээний нөхцөл',
                  onTap: controller.onTapTerms,
                ),
                const SizedBox(height: 16),
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
                  onTap: controller.isConfirmed.toggle,
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
                            value: controller.isConfirmed.value,
                            onChanged: controller.isConfirmed.call,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
