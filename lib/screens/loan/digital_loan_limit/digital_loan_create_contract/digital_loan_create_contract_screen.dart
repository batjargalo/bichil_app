import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import 'digital_loan_create_contract_controller.dart';

class DigitalLoanContractScreen extends GetView<DigitalLoanContractController> {
  const DigitalLoanContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: "Зээлийн гэрээ"),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: HtmlWidget(
                  controller.html.value,
                  textStyle: IOStyles.body2Regular,
                ),
              ),
      ),
      bottomSheet: IOBottomNavigationBar(
        backgroundColor: IOColors.backgroundPrimary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IOGesture(
              onTap: controller.isConfirmed.toggle,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: IOColors.brand100),
                ),
                child: Row(
                  children: [
                    SizedBox.square(
                      dimension: 16,
                      child: IOCheckbox(
                        value: controller.isConfirmed.value,
                        onChanged: controller.isConfirmed.call,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Би дээрх нөхцөлүүдийг зөвшөөрч байна.',
                      style: IOStyles.caption1Regular,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            IOGesture(
              onTap: controller.isConfirmed.toggle,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: IOColors.brand100),
                ),
                child: Row(
                  children: [
                    SizedBox.square(
                      dimension: 16,
                      child: IOCheckbox(
                        value: controller.isConfirmed.value,
                        onChanged: controller.isConfirmed.call,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Би дээрх нөхцөлүүдийг зөвшөөрч байна.',
                      style: IOStyles.caption1Regular,
                    ),
                  ],
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
    );
  }
}
