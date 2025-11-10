import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateSavingConditionScreen
    extends GetView<LoanCreateSavingConditionController> {
  const LoanCreateSavingConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Итгэлцэл барьцаалсан зээл',
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Зээлийн хэмжээгээ оруулна уу.',
                      style: IOStyles.body2Semibold,
                    ),
                    const SizedBox(height: 12),
                    LoanRecreateAmountWidget(
                      maxValue: controller.create.maxAmount,
                      // currentValue: controller.amount.value,
                      onChanged: controller.amount.call,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0₮',
                          style: IOStyles.caption1SemiBold.copyWith(
                            color: IOColors.textTertiary,
                          ),
                        ),
                        Text(
                          controller.create.maxAmount.toCurrency(),
                          style: IOStyles.caption1SemiBold.copyWith(
                            color: IOColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Зээлийн мэдээлэл',
                      style: IOStyles.body2Semibold,
                    ),
                    const SizedBox(height: 12),
                    IOCardBorderWidget(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          RowWidget(
                            title: 'Хүү (сараар)',
                            value:
                                '${controller.create.rate.toStringAsFixed(2)}%',
                            titleStyle: IOStyles.caption1SemiBold.copyWith(
                              color: IOColors.textSecondary,
                            ),
                            valueStyle: IOStyles.body2Bold.copyWith(
                              color: IOColors.brand500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RowWidget(
                            title: 'Хугацаа',
                            value:
                                controller.saving.closeDate.toFormattedString(
                              format: 'yyyy/MM/dd',
                            ),
                            titleStyle: IOStyles.caption1SemiBold.copyWith(
                              color: IOColors.textSecondary,
                            ),
                            valueStyle: IOStyles.body2Bold.copyWith(
                              color: IOColors.brand500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
        bottomNavigationBar: IOBottomNavigationBar(
          backgroundColor: IOColors.backgroundPrimary,
          child: IOButtonWidget(
            model: controller.next.value,
            onPressed: controller.onTapNext,
          ),
        ),
      ),
    );
  }
}
