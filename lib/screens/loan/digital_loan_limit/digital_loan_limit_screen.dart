import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DigitalLoanLimitScreen extends GetView<DigitalLoanLimitController> {
  const DigitalLoanLimitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: controller.titleText),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : IORefresher(
                controller: controller.refresher,
                onRefresh: controller.onRefresh,
                child: Column(
                  children: [
                    SizedBox(
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: IOCardBorderWidget(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox.square(dimension: 60, child: Image.asset('assets/images/noncoll.png')),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Зээлийн дээд эрх - ${controller.loanLimit.first.scoreLimit.toCurrency()}',
                                            style: IOStyles.body2Bold,
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              SvgPicture.asset('assets/icons/clock.svg', width: 12, height: 12),
                                              const SizedBox(width: 4),
                                              Text(
                                                "7 хоног ~ 12 сар",
                                                style: IOStyles.caption2Bold.copyWith(color: IOColors.textTertiary),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Боломжит хэмжээ',
                                            style: IOStyles.caption1Regular.copyWith(color: IOColors.brand500),
                                          ),
                                          Text(
                                            controller.loanLimit.first.loanLimit.toCurrency(),
                                            style: IOStyles.body2Semibold.copyWith(color: IOColors.textSecondary),
                                          ),
                                          Text(
                                            'Нийт авсан зээлийн тоо',
                                            style: IOStyles.caption1Regular.copyWith(color: IOColors.brand500),
                                          ),
                                          Text(
                                            controller.loanLimit.first.loanCount.toString(),
                                            style: IOStyles.body2Semibold.copyWith(color: IOColors.textSecondary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 100),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  controller.loanLimit.first.scoreLimit == 0
                                      ? LoanPayInfoWidget(
                                          editable: false,
                                          title: 'Зээлийн эрх тогтоолгох хураамж',
                                          isLoading: controller.limitChargeLoading.value,
                                          initialValue: controller.chargeAmount.value,
                                          onPay: (type) => controller.onPay(LoanLimitType.create, type),
                                        )
                                      : LoanPayInfoWidget(
                                          editable: false,
                                          title: 'Зээлийн эрх шинчлэх хураамж',
                                          isLoading: controller.limitChargeLoading.value,
                                          initialValue: controller.chargeAmount.value,
                                          onPay: (type) => controller.onPay(LoanLimitType.change, type),
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
