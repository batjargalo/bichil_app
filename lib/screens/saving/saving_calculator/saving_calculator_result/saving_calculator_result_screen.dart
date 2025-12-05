import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SavingCalculatorResultScreen
    extends GetView<SavingCalculatorResultController> {
  const SavingCalculatorResultScreen({super.key});

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Container(
                width: 96,
                height: 96,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: IOColors.brand50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.asset(
                  'assets/icons/money.cash.svg',
                  colorFilter: const ColorFilter.mode(
                    IOColors.brand500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                controller.model.periodAmount.toCurrency(),
                style: IOStyles.h1.copyWith(
                  color: IOColors.brand500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${controller.model.frequency.title} авах өгөөж',
                style: IOStyles.caption1SemiBold,
              ),
              const SizedBox(height: 32),
              SavingCalculatorResultWidget(
                model: controller.model,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
