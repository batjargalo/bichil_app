import 'package:bichil/library/components/button/io_button_model.dart';
import 'package:bichil/library/components/button/io_button_widget.dart';
import 'package:bichil/library/components/components.dart';
import 'package:bichil/library/components/main/io_card_border.dart';
import 'package:bichil/library/components/main/io_loading.dart';
import 'package:bichil/library/components/main/io_refresher.dart';
import 'package:bichil/library/theme/io_colors.dart';
import 'package:bichil/library/theme/io_styles.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DigitalLoanLimitScreen extends GetView<DigitalLoanLimitController> {
  const DigitalLoanLimitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: 'Дижитал зээл'),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : IORefresher(
                controller: controller.refresher,
                onRefresh: controller.onRefresh,
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Дижитал зээл",
                                      style: IOStyles.body2Bold,
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
                                      "5,000,000₮ хүртэл",
                                      style: IOStyles.body2Semibold.copyWith(
                                        color: IOColors.textSecondary,
                                      ),
                                    ),
                                    const Spacer(),
                                    controller
                                                .loanLimit
                                                .first
                                                .limitCalcButton ==
                                            true
                                        ? IOButtonWidget(
                                            onPressed: () {},
                                            model: IOButtonModel(
                                              label: 'Зээлийн эрх тогтоох',
                                              type: IOButtonType.primary,
                                              size: IOButtonSize.small,
                                            ),
                                          )
                                        : IOButtonWidget(
                                            onPressed: () {},
                                            model: IOButtonModel(
                                              label: 'Зээлийн эрх шинчлэх',
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
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String label, bool selected) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.blue : Colors.white,
            fontSize: 16,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
