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
                                    dimension: 80,
                                    child: Image.asset(
                                      'assets/images/noncoll.png',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/coins.svg',
                                              width: 12,
                                              height: 12,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '5 сая хүртэл',
                                              style: IOStyles.body2Bold,
                                            ),
                                          ],
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
                                              style: IOStyles.body2Bold,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              // IOButtonWidget(
                              //   onPressed: controller.onCreateLoan,
                              //   model: controller.takeLoan.value,
                              // ),
                              Obx(
                                () => LoanLimitChargePayWidget(
                                  editable: false,
                                  title: 'Зээл авах',
                                  isLoading:
                                      controller.limitChargeLoading.value,
                                  initialValue: controller.chargeAmount.value,
                                  onPay: (type) => controller.onPay(
                                    LoanLimitType.create,
                                    type,
                                  ),
                                ),
                              ),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.stretch,
                              //   children: [
                              //     controller.loanLimit.first.scoreLimit == 0
                              //         ? Obx(
                              //             () => LoanLimitChargePayWidget(
                              //               editable: false,
                              //               title: 'Зээлийн эрх тогтоолгох',
                              //               isLoading: controller
                              //                   .limitChargeLoading
                              //                   .value,
                              //               initialValue:
                              //                   controller.chargeAmount.value,
                              //               onPay: (type) => controller.onPay(
                              //                 LoanLimitType.create,
                              //                 type,
                              //               ),
                              //             ),
                              //           )
                              //         : Obx(
                              //             () => LoanLimitChargePayWidget(
                              //               editable: false,
                              //               title: 'Зээлийн эрх шинэчлэх',
                              //               isLoading: controller
                              //                   .limitChargeLoading
                              //                   .value,
                              //               initialValue:
                              //                   controller.chargeAmount.value,
                              //               onPay: (type) => controller.onPay(
                              //                 LoanLimitType.change,
                              //                 type,
                              //               ),
                              //             ),
                              //           ),
                              //   ],
                              // ),
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
