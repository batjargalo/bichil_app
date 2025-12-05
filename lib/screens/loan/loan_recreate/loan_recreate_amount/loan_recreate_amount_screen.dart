import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanRecreateAmountScreen extends GetView<LoanRecreateAmountController> {
  const LoanRecreateAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Давтан зээл авах',
      ),
      body: Obx(
        () => GestureDetector(
          onTap: Get.focusScope?.unfocus,
          behavior: HitTestBehavior.opaque,
          child: SizedBox.expand(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Зээлийн хэмжээгээ оруулна уу.',
                      style: IOStyles.body1SemiBold,
                    ),
                    const SizedBox(height: 24),
                    LoanRecreateAmountWidget(
                      maxValue: controller.item.availComBal,
                      // currentValue: controller.amount.value,
                      onChanged: controller.amount.call,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '0₮',
                          style: IOStyles.caption1SemiBold.copyWith(
                            color: IOColors.textTertiary,
                          ),
                        ),
                        Text(
                          controller.item.availComBal.toCurrency(),
                          style: IOStyles.caption1SemiBold.copyWith(
                            color: IOColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Эргэн төлөлтийн мэдээлэл',
                          style: IOStyles.body2Semibold.copyWith(
                            color: IOColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Хүү - ${controller.item.baseFixedIntRate}%',
                          style: IOStyles.caption1SemiBold.copyWith(
                            color: IOColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    IOCardBorderWidget(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          RowWidget(
                            title: 'Нийт төлөх дүн',
                            value: 0.0.toCurrency(),
                            titleStyle: IOStyles.caption1SemiBold.copyWith(
                              color: IOColors.textSecondary,
                            ),
                            valueStyle: IOStyles.body2Bold.copyWith(
                              color: IOColors.brand500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RowWidget(
                            title: 'Сард төлөх дүн',
                            value: 0.0.toCurrency(),
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
                    const Spacer(),
                    // Expanded(
                    //   child: IOAmountField(
                    //     text: controller.amount.value.toCurrency(),
                    //     onChanged: controller.amount.call,
                    //   ),
                    // ),
                    IOButtonWidget(
                      model: controller.button.value,
                      onPressed: controller.onTapNext,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
