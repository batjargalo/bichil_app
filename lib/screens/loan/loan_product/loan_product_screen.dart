import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/digital_loan_limit/widgets/digital_loan_charge_widget.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoanProductScreen extends GetView<LoanProductController> {
  const LoanProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isInitialLoading.value
          ? const IOLoading()
          : IORefresher(
              controller: controller.refresher,
              onRefresh: controller.onRefresh,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: IOCardBorderWidget(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Дижитал зээл", style: IOStyles.body2Bold),
                            const Spacer(),
                            Text(
                              controller.loanLimit.first.message,
                              style: IOStyles.caption2Regular.copyWith(
                                color: IOColors.textSecondary,
                              ),
                            ),

                            const Spacer(),

                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/clock.svg',
                                  width: 12,
                                  height: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "7 хоног ~ 12 сар",
                                  style: IOStyles.caption2Bold.copyWith(
                                    color: IOColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              'Боломжит хэмжээ',
                              style: IOStyles.caption1Regular.copyWith(
                                color: IOColors.brand500,
                              ),
                            ),
                            Text(
                              controller.loanLimit.first.scoreLimit
                                  .toCurrency(),
                              style: IOStyles.body2Semibold.copyWith(
                                color: IOColors.textSecondary,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Expanded(
                                  child: Obx(
                                    () => LoanLimitChargePayWidget(
                                      editable: false,
                                      title: 'Эрх шинэчлэх',
                                      isLoading:
                                          controller.limitChargeLoading.value,
                                      initialValue:
                                          controller.chargeAmount.value,
                                      onPay: (type) => controller.onPay(
                                        LoanLimitType.create,
                                        type,
                                      ),
                                    ),
                                  ),
                                  //  IOButtonWidget(
                                  //   onPressed: controller.onScoreCal,
                                  //   model: IOButtonModel(
                                  //     label: 'Эрх шинэчлэх',
                                  //     type: IOButtonType.primary,
                                  //     size: IOButtonSize.small,
                                  //   ),
                                  // ),
                                ),

                                Expanded(
                                  child: IOButtonWidget(
                                    onPressed: controller.onCreateLoan,
                                    model: IOButtonModel(
                                      label: 'Зээл авах',
                                      type: IOButtonType.primary,
                                      size: IOButtonSize.small,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: IOCardBorderWidget(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Барьцаатай зээл", style: IOStyles.body2Bold),
                            const Spacer(),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/clock.svg',
                                  width: 12,
                                  height: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "2 сар ~ 36 сар",
                                  style: IOStyles.caption2Bold.copyWith(
                                    color: IOColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              'Боломжит хэмжээ',
                              style: IOStyles.caption1Regular.copyWith(
                                color: IOColors.brand500,
                              ),
                            ),
                            Text(
                              "30% ~ 80% хүртэл",
                              style: IOStyles.body2Semibold.copyWith(
                                color: IOColors.textSecondary,
                              ),
                            ),
                            const Spacer(),
                            IOButtonWidget(
                              onPressed: controller.onTapLoan,
                              model: IOButtonModel(
                                label: 'Зээлийн хүсэлт илгээх',
                                type: IOButtonType.primary,
                                size: IOButtonSize.small,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
