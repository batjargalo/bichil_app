import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingAddScreen extends GetView<SavingAddController> {
  const SavingAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Мөнгө нэмэх',
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Боломжит бага дүн:',
                      style: IOStyles.body1Regular,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.minimumAmount.toCurrency(fractionDigits: 0),
                      style: IOStyles.body1Bold,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                IOAmountField(
                  text: controller.amount.value.toCurrency(),
                  onChanged: controller.amount.call,
                ),
                const Spacer(),
                IOButtonWidget(
                  model: controller.qpay.value,
                  onPressed: controller.onTapAdd,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
