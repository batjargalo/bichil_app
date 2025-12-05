import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingCreateConfirmScreen extends GetView<SavingCreateConfirmController> {
  const SavingCreateConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Итгэлцэл нээх',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      controller.create.totalAmount.toCurrency(),
                      style: IOStyles.h3.copyWith(
                        color: IOColors.brand500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              IOCardBorderWidget(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    SavingCreateConfirmWidget(
                      title: 'Итгэлцлийн нэр',
                      value: controller.create.name,
                    ),
                    SavingCreateConfirmWidget(
                      title: 'Нээх мөнгөн дүн',
                      value: controller.create.firstAmount.toCurrency(),
                    ),
                    SavingCreateConfirmWidget(
                      title: 'Үр шим',
                      value: '${controller.create.rate}%',
                    ),
                    SavingCreateConfirmWidget(
                      title: 'Хугацаа',
                      value: controller.create.term.name,
                    ),
                    SavingCreateConfirmWidget(
                      title: 'Өгөөж авах давтамж',
                      value: controller.create.frequency.name,
                    ),
                    const Divider(),
                    SavingCreateConfirmWidget(
                      title: '${controller.create.frequency.name} авах өгөөж',
                      value: controller.create.periodYield.toCurrency(),
                    ),
                    SavingCreateConfirmWidget(
                      title: 'Нийт авах өгөөж',
                      value: controller.create.totalYield.toCurrency(),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          backgroundColor: IOColors.backgroundPrimary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: IOColors.warningSecondary,
                ),
                child: Text(
                  'Та ХХОАТ-с чөлөөлөгддөг бол нотлох баримтын хамт өөрт ойр манай салбарт ирж баталгаажуулна уу',
                  style: IOStyles.body2Regular.copyWith(
                    color: IOColors.warningPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: IOButtonWidget(
                      model: controller.next.value,
                      onPressed: controller.onTapNext,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
