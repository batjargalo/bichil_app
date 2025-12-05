import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCalculatorFormScreen extends GetView<LoanCalculatorFormController> {
  const LoanCalculatorFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: controller.hasAppBar
            ? IOAppBar(
                titleText: 'Зээлийн тооцоолуур',
              )
            : null,
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : GestureDetector(
                onTap: Get.focusScope?.unfocus,
                child: SizedBox.expand(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        IOTextfieldWidget(
                          model: controller.amount,
                        ),
                        const SizedBox(height: 16),
                        IOTextfieldWidget(
                          model: controller.period,
                        ),
                        const SizedBox(height: 16),
                        IOTextfieldWidget(
                          model: controller.rate,
                        ),
                        // IODropdownWidget(
                        //   model: controller.type,
                        //   pickItems: controller.loans.toList(),
                        //   onSelect: controller.onSelectType,
                        // ),
                        const SizedBox(height: 16),
                        LoanCalculatorFormTypeWiget(
                          items: controller.types,
                          selected: controller.selectedType.value,
                          onChanged: controller.selectedType.call,
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
