import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingCalculatorFormScreen
    extends GetView<SavingCalculatorFormController> {
  const SavingCalculatorFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: controller.hasAppBar
            ? IOAppBar(titleText: 'Итгэлцлийн тооцоолуур')
            : null,
        body: GestureDetector(
          onTap: Get.focusScope?.unfocus,
          child: SizedBox.expand(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  IOTextfieldWidget(model: controller.amount),
                  const SizedBox(height: 16),
                  SavingCalculatorFormPeriodWidget(
                    items: controller.periodTypes,
                    selected: controller.selectedPeriod.value,
                    onChanged: controller.selectedPeriod.call,
                  ),
                  const SizedBox(height: 16),
                  SavingCalculatorFormFreqWidget(
                    items: controller.freqTypes,
                    selected: controller.selectedFreq.value,
                    onChanged: controller.selectedFreq.call,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          child: IOButtonWidget(
            model: controller.button.value,
            onPressed: controller.onTapCalculate,
          ),
        ),
      ),
    );
  }
}
