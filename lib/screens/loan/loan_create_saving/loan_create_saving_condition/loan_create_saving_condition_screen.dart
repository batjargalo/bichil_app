import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateSavingConditionScreen extends GetView<LoanCreateSavingConditionController> {
  const LoanCreateSavingConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(titleText: 'Итгэлцэл барьцаалсан зээл'),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 120, // Set height for your cards
                      child: PageView.builder(
                        itemCount: controller.saving.length,
                        onPageChanged: controller.onPageChanged,
                        controller: PageController(viewportFraction: 0.9), // Peek next card
                        itemBuilder: (context, index) {
                          final List<Alignment> begins = [
                            Alignment.topLeft,
                            Alignment.topRight,
                            Alignment.bottomLeft,
                            Alignment.topCenter,
                          ];
                          final List<Alignment> ends = [
                            Alignment.bottomRight,
                            Alignment.bottomLeft,
                            Alignment.topRight,
                            Alignment.bottomCenter,
                          ];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  begin: begins[index % begins.length],
                                  end: ends[index % ends.length],
                                  colors: const [Color.fromARGB(255, 59, 13, 245), Color.fromRGBO(0, 174, 164, 45)],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.saving[index].accountName,
                                    style: IOStyles.body1Bold.copyWith(color: Colors.white),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'Боломжит дээд дүн:',
                                    style: TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.create[index].maxAmount.toCurrency(),
                                      style: IOStyles.body1Bold.copyWith(color: Colors.white, fontSize: 32),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.saving.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: controller.activeIndex.value == index ? 24 : 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: controller.activeIndex.value == index
                                  ? const Color(0xFF3B0DF5)
                                  : Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text('Зээлийн хэмжээгээ оруулна уу.', style: IOStyles.body2Semibold),
                    const SizedBox(height: 12),
                    LoanRecreateAmountWidget(
                      maxValue: controller.create[controller.activeIndex.value].maxAmount,
                      // currentValue: controller.amount.value,
                      onChanged: controller.amount.call,
                    ),
                    const SizedBox(height: 32),
                    const Text('Зээлийн мэдээлэл', style: IOStyles.body2Semibold),
                    const SizedBox(height: 12),
                    IOCardBorderWidget(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          RowWidget(
                            title: 'Хүү (сараар)',
                            value: '${controller.create[controller.activeIndex.value].rate.toStringAsFixed(2)}%',
                            titleStyle: IOStyles.caption1SemiBold.copyWith(color: IOColors.textSecondary),
                            valueStyle: IOStyles.body2Bold.copyWith(color: IOColors.brand500),
                          ),
                          const SizedBox(height: 8),
                          RowWidget(
                            title: 'Хугацаа',
                            value: controller.saving[controller.activeIndex.value].closeDate.toFormattedString(
                              format: 'yyyy/MM/dd',
                            ),
                            titleStyle: IOStyles.caption1SemiBold.copyWith(color: IOColors.textSecondary),
                            valueStyle: IOStyles.body2Bold.copyWith(color: IOColors.brand500),
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
          child: IOButtonWidget(model: controller.next.value, onPressed: controller.onTapNext),
        ),
      ),
    );
  }
}
