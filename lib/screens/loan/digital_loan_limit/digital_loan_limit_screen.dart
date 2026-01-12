import 'package:bichil/library/library.dart';
import 'widgets/digital_loan_charge_widget.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DigitalLoanLimitScreen extends GetView<DigitalLoanLimitController> {
  const DigitalLoanLimitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: 'Дижитал зээлийн эрх'),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : IORefresher(
                controller: controller.refresher,
                onRefresh: controller.onRefresh,
                child: Column(
                  children: [
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom -
                          MediaQuery.of(context).viewInsets.bottom -
                          kToolbarHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: IOCardBorderWidget(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox.square(
                                    dimension: 60,
                                    child: Image.asset(
                                      'assets/images/noncoll.png',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  controller.loanLimit.first.scoreLimit == 0
                                      ? Flexible(
                                          child: Text(
                                            controller.loanLimitText.value,
                                            style: IOStyles.body1Medium,
                                            overflow: TextOverflow.clip,
                                            softWrap: true,
                                          ),
                                        )
                                      : Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                'Зээлийн дээд эрх - ${controller.loanLimit.first.scoreLimit.toCurrency()}',
                                                style: IOStyles.body2Bold,
                                              ),
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
                                                    style: IOStyles.caption2Bold
                                                        .copyWith(
                                                          color: IOColors
                                                              .textTertiary,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Боломжит хэмжээ',
                                                style: IOStyles.caption1Regular
                                                    .copyWith(
                                                      color: IOColors.brand500,
                                                    ),
                                              ),
                                              Text(
                                                controller
                                                    .loanLimit
                                                    .first
                                                    .loanLimit
                                                    .toCurrency(),
                                                style: IOStyles.body2Semibold
                                                    .copyWith(
                                                      color: IOColors
                                                          .textSecondary,
                                                    ),
                                              ),
                                              Text(
                                                'Нийт авсан зээлийн тоо',
                                                style: IOStyles.caption1Regular
                                                    .copyWith(
                                                      color: IOColors.brand500,
                                                    ),
                                              ),
                                              Text(
                                                controller
                                                    .loanLimit
                                                    .first
                                                    .loanCount
                                                    .toString(),
                                                style: IOStyles.body2Semibold
                                                    .copyWith(
                                                      color: IOColors
                                                          .textSecondary,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: 25),
                              controller.loanLimit.first.scoreLimit != 0
                                  ? (controller.loanLimit.first.contract
                                        ? IOButtonWidget(
                                            onPressed: controller.onCreateLoan,
                                            model: controller.takeLoan.value,
                                          )
                                        : IOButtonWidget(
                                            onPressed:
                                                controller.onSignContract,
                                            model:
                                                controller.signContract.value,
                                          ))
                                  : SizedBox(height: 10),

                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  controller.loanLimit.first.scoreLimit == 0
                                      ? Obx(
                                          () => LoanLimitChargePayWidget(
                                            editable: false,
                                            title: 'Зээлийн эрх тогтоолгох',
                                            isLoading: controller
                                                .limitChargeLoading
                                                .value,
                                            initialValue:
                                                controller.chargeAmount.value,
                                            onPay: (type) => controller.onPay(
                                              LoanLimitType.create,
                                              type,
                                            ),
                                          ),
                                        )
                                      : Obx(
                                          () => LoanLimitChargePayWidget(
                                            editable: false,
                                            title: 'Зээлийн эрх шинэчлэх',
                                            isLoading: controller
                                                .limitChargeLoading
                                                .value,
                                            initialValue:
                                                controller.chargeAmount.value,
                                            onPay: (type) => controller.onPay(
                                              LoanLimitType.change,
                                              type,
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
                  ],
                ),
              ),
      ),
    );
  }
}
