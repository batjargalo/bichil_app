import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/digital_loan_create/digital_loan_ceate_amount/widgets/digital_loan_duration_scroll_widget.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DigitalLoanCreateAmountScreen
    extends GetView<DigitalLoanCreateAmountController> {
  const DigitalLoanCreateAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: 'Дижитал зээл авах'),
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
                      maxValue: controller.item.loanLimit,
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
                          controller.item.loanLimit.toCurrency(),
                          style: IOStyles.caption1SemiBold.copyWith(
                            color: IOColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    controller.amount.value == 0
                        ? const SizedBox.shrink()
                        : const Text(
                            'Зээлийн хугацаагаа сонгоно уу.',
                            style: IOStyles.body1SemiBold,
                          ),
                    const SizedBox(height: 16),
                    controller.amount.value == 0
                        ? const SizedBox.shrink()
                        : LoanDurationWidget(
                            onChanged: controller.term.call,
                            setDuration: controller.setSelectedTerm,
                            amount: controller.amount.value,
                            durations: controller.getDurationList(),
                          ),
                    const SizedBox(height: 16),
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
                        // Text(
                        //   'Хүү - 4%',
                        //   // 'Хүү - ${controller.item.loanLimit}%',
                        //   style: IOStyles.caption1SemiBold.copyWith(
                        //     color: IOColors.textSecondary,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    IOCardBorderWidget(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          RowWidget(
                            title: 'Нийт төлөх дүн',
                            value: controller.totalPayment.value.toCurrency(),
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
                            value: controller.mountlyPayment.value.toCurrency(),
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
