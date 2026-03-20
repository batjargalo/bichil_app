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
              child: controller.isInitialLoading.value
                  ? const IOLoading()
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ${controller.loanLimit.first.loanLimit.toCurrency()}
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,

                                colors: [
                                  Color.fromARGB(
                                    255,
                                    59,
                                    13,
                                    245,
                                  ), // Bright Blue
                                  Color.fromRGBO(0, 174, 164, 45), // Teal/Cyan
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Зээлийн нийт эрх',
                                      style: IOStyles.body1Bold.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  controller.loanLimit.first.scoreLimit
                                      .toCurrency(),
                                  style: IOStyles.body1Bold.copyWith(
                                    color: Colors.white,
                                    fontSize: 42, // Large display size
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Зээлийн хэмжээгээ оруулна уу.',
                                style: IOStyles.body2Semibold.copyWith(
                                  color: IOColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          LoanRecreateAmountWidget(
                            maxValue: controller.loanLimit.first.scoreLimit,
                            // currentValue: controller.amount.value,
                            onChanged: controller.amount.call,
                          ),
                          const SizedBox(height: 16),

                          controller.amount.value == 0
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Зээлийн хугацаагаа сонгоно уу.',
                                      style: IOStyles.body2Semibold.copyWith(
                                        color: IOColors.textTertiary,
                                      ),
                                    ),
                                  ],
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Эргэн төлөлтийн мэдээлэл',
                                style: IOStyles.body2Semibold.copyWith(
                                  color: IOColors.textTertiary,
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
                                  value: controller.totalPayment.value
                                      .toCurrency(),
                                  titleStyle: IOStyles.caption1SemiBold
                                      .copyWith(color: IOColors.textSecondary),
                                  valueStyle: IOStyles.body2Bold.copyWith(
                                    color: IOColors.brand500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RowWidget(
                                  title: 'Сард төлөх дүн',
                                  value: controller.mountlyPayment.value
                                      .toCurrency(),
                                  titleStyle: IOStyles.caption1SemiBold
                                      .copyWith(color: IOColors.textSecondary),
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
