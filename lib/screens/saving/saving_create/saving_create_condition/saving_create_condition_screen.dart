import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingCreateConditionScreen
    extends GetView<SavingCreateConditionController> {
  const SavingCreateConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Итгэлцэл нээх',
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : GestureDetector(
                onTap: Get.focusScope?.unfocus,
                child: SizedBox.expand(
                  child: AbsorbPointer(
                    absorbing: controller.isLoading.value,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          IOTextfieldWidget(model: controller.name),
                          const SizedBox(height: 16),
                          IOTextfieldWidget(model: controller.amount),
                          Text(
                            '${controller.condition.minimumAmountBalance.toCurrency()} дээш',
                            style: IOStyles.caption1Regular.copyWith(
                              color: IOColors.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Байршуулах хугацаа',
                            style: IOStyles.body2Semibold,
                          ),
                          const SizedBox(height: 8),
                          SavingCreateConditionMonthWidget(
                            months: controller.condition.periodOptions.toList(),
                            selectedMonth: controller.create.term,
                            onSelect: controller.onTapMonth,
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Өгөөж авах давтамж',
                            style: IOStyles.body2Semibold,
                          ),
                          const SizedBox(height: 8),
                          SavingCresteConditionFrequencyWidget(
                            options:
                                controller.condition.frequencyOptions.toList(),
                            selectedOption: controller.create.frequency,
                            onSelect: controller.onTapOption,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Өгөөж авах хуваарь',
                                style: IOStyles.body2Semibold,
                              ),
                              Text(
                                'Үр шим (жил) ${controller.create.rate == 0 ? '-' : '${controller.create.rate}%'}',
                                style: IOStyles.body2Semibold.copyWith(
                                  color: IOColors.brand500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          IOCardBorderWidget(
                            padding: const EdgeInsets.all(16),
                            child: controller.schedule.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final item = controller.schedule[index];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.date,
                                            style: IOStyles.caption1SemiBold
                                                .copyWith(
                                              color: IOColors.textSecondary,
                                            ),
                                          ),
                                          Text(
                                            item.amount.toCurrency(),
                                            style: IOStyles.body2Bold.copyWith(
                                              color: IOColors.brand500,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 8);
                                    },
                                    itemCount: controller.schedule.length,
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '-',
                                        style:
                                            IOStyles.caption1SemiBold.copyWith(
                                          color: IOColors.textSecondary,
                                        ),
                                      ),
                                      Text(
                                        '-',
                                        style: IOStyles.body2Bold.copyWith(
                                          color: IOColors.brand500,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 10),
                          IOCardBorderWidget(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                const Text(
                                  'Нийт хуримтлагдах дүн',
                                  style: IOStyles.body2Semibold,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  (controller.create.totalAmount).toCurrency(),
                                  style: IOStyles.h3.copyWith(
                                    color: IOColors.brand500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
