import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingCloseAmountScreen extends GetView<SavingCloseAmountController> {
  const SavingCloseAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Хэсэгчилж авах',
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                IOCardBorderWidget(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      RowWidget(
                        title: 'Авах дээд дүн',
                        value: controller.model.saving.availBal
                            .toCurrency(fractionDigits: 0),
                      ),
                      const Divider(),
                      RowWidget(
                        title: 'Авах доод дүн',
                        value: controller.model.minimumAmount
                            .toCurrency(fractionDigits: 0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                IOAmountField(
                  text: controller.amount.value.toCurrency(),
                  onChanged: controller.amount.call,
                ),
                const Spacer(),
                IOButtonWidget(
                  model: controller.button.value,
                  onPressed: controller.onTapNext,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
