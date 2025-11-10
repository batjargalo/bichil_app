import 'dart:async';

import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingCreateConditionController extends IOController {
  late SavingCreateConditionModel condition;
  final create = SavingCreateModel();

  final schedule = <SavingCalculatorScheduleModel>[].obs;
  double get amountVal => formatter.getUnformattedValue().toDouble();
  Timer? timer;

  final formatter = CurrencyTextInputFormatter.currency(
    symbol: '',
    decimalDigits: 0,
  );
  final name = IOTextfieldModel(
    label: 'Итгэлцэлдээ нэр өгөөрэй',
    validators: [ValidatorType.notEmpty],
  );

  late final amount = IOTextfieldModel(
    label: 'Байршуулах дүн ₮',
    inputFormatters: [formatter],
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.number,
  );

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  final hasSubscribe = false.obs;

  @override
  void onInit() {
    super.onInit();
    amount.controller.addListener(onChangedAmount);
    name.status.addListener(checkValidation);
    amount.status.addListener(checkValidation);
    fetchData();
  }

  @override
  void onClose() {
    timer?.cancel();
    amount.controller.removeListener(onChangedAmount);
    name.status.removeListener(checkValidation);
    amount.status.removeListener(checkValidation);
    super.onClose();
  }

  void onChangedAmount() {
    create.firstAmount = amountVal;
    timer?.cancel();
    timer = Timer(const Duration(seconds: 1), calculateSaving);
  }

  void checkValidation() {
    next.update((val) {
      val?.isEnabled = name.isValid && formatter.getUnformattedValue() != 0;
    });
  }

  Future fetchData() async {
    isInitialLoading.value = true;
    final response = await SavingApi().getSavingCondition();

    if (response.isSuccess) {
      condition = SavingCreateConditionModel.fromJson(response.data);
      create.term = condition.periodOptions.first;
      create.frequency = condition.frequencyOptions.first;
      isInitialLoading.value = false;

      if (condition.isDepositAvailable == false) {
        Get.back();
        showWarning(text: 'Түр хугацаанд д мөнгө нэмэх боломжгүй байна.');
      }
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future calculateSaving() async {
    if (create.firstAmount == 0) return;
    isLoading.value = true;
    next.update((val) {
      val?.isLoading = true;
    });

    final data = {
      'total_amount': amountVal,
      'total_months': create.term.value,
      'yield_frequency': create.frequency.value,
    };

    final response = await SavingApi().getCalculate(data: data);

    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      schedule.value = response.data['schedule'].listValue
          .map((e) => SavingCalculatorScheduleModel.fromJson(e))
          .toList();
      create.totalYield = response.data['total_yield'].ddoubleValue;
      create.periodYield = response.data['period_yield'].ddoubleValue;
      create.rate = response.data['interest_rate'].ddoubleValue;
      refresh();
    } else {
      showError(text: response.message);
    }
  }

  Future onTapMonth(SavingCreateFrequencyModel value) async {
    create.term = value;
    isLoading.value = false;
    await calculateSaving();
  }

  Future onTapOption(SavingCreateFrequencyModel value) async {
    create.frequency = value;
    isLoading.value = false;
    await calculateSaving();
  }

  void onTapNext() {
    final month = int.tryParse(create.term.value) ?? 0;
    if (month < condition.minimumPeriodMonths) {
      showWarning(
        text: 'Итгэлцэл нээх хугацаа бага байна',
        acceptText: 'Тийм',
      );
      return;
    }
    if (month > condition.maximumPeriodMonths) {
      showWarning(
        text: 'Итгэлцэл нээх хугацаа их байна',
        acceptText: 'Тийм',
      );
      return;
    }
    if (amountVal < condition.minimumAmountBalance) {
      showWarning(
        text: 'Итгэлцэл нээх мөнгөн дүн бага байна',
        acceptText: 'Тийм',
      );
      return;
    }
    create.name = name.value;
    create.firstAmount = amountVal;
    create.hasSubscribe = hasSubscribe.value;
    SavingRoute.toCreateConfirm(create);
  }
}
