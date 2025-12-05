import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateSavingPageController extends IOController {
  final SavingDetailModel saving;
  final title = 'Зээл авах';
  final pageController = PageController();

  final screens = const [
    LoanCreateSavingConditionScreen(),
    LoanCreateSavingConfirmScreen(),
  ];
  late double rate;
  late double maxAmount;
  late int maxTerm;

  late double amount;
  final int payDay = 0;
  final int term = 0;

  LoanCreateSavingPageController({
    required this.saving,
  });

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future fetchData() async {
    isInitialLoading.value = true;
    final response = await LoanApi().getLoanSavingRate(
      code: saving.accountNumber,
    );

    if (response.isSuccess) {
      rate = response.data['rateMonth'].ddoubleValue;
      maxAmount = response.data['maxAmount'].ddoubleValue;
      maxTerm = response.data['maxTerm'].integerValue;
      isInitialLoading.value = false;
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
