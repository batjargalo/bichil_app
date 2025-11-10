import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCalculatorResultScreen
    extends GetView<LoanCalculatorResultController> {
  const LoanCalculatorResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Тооцоолуур',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              LoanCalculatorResultHeaderWidget(
                model: controller.model,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LoanCalculatorResultTableWidget(
                  model: controller.model,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
