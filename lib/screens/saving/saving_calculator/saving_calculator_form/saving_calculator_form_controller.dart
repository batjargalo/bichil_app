import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingCalculatorFormController extends IOController {
  final bool hasAppBar;

  final formatter = CurrencyTextInputFormatter.currency(
    symbol: '',
    decimalDigits: 0,
  );

  late final amount = IOTextfieldModel(
    label: 'Итгэлцэл нээх мөнгөн дүн',
    inputFormatters: [formatter],
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.number,
  );
  final button = IOButtonModel(
    label: 'Тооцоолох',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
    isExpanded: true,
  ).obs;

  final periodTypes = [
    SavingCalculatorPeriodType.year,
    SavingCalculatorPeriodType.month,
  ];

  final freqTypes = [
    SavingCalculatorFrequencyType.quarter,
    SavingCalculatorFrequencyType.semiAnnual,
    SavingCalculatorFrequencyType.annual,
  ];

  final selectedPeriod = SavingCalculatorPeriodType.year.obs;
  final selectedFreq = SavingCalculatorFrequencyType.quarter.obs;

  SavingCalculatorFormController({required this.hasAppBar});

  @override
  void onInit() {
    super.onInit();
    amount.status.addListener(chechValidation);
  }

  void chechValidation() {
    button.update((val) {
      val?.isEnabled = formatter.getUnformattedValue() != 0;
    });
  }

  Future onTapCalculate() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    button.update((val) {
      val?.isLoading = true;
    });

    final model = SavingCalculatorModel(
      amount: formatter.getUnformattedValue().toDouble(),
      period: selectedPeriod.value,
      frequency: selectedFreq.value,
    );

    final response = await SavingApi().getCalculate(data: model.toMap());

    isLoading.value = false;
    button.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      model.totalAmount = response.data['total_yield'].ddoubleValue;
      model.periodAmount = response.data['period_yield'].ddoubleValue;
      SavingRoute.toCalculatorResult(model: model);
    } else {
      showError(text: response.message);
    }
  }
}
