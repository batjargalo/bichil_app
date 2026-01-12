import 'dart:async';

import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends IOController {
  final tab = Get.find<TabBarController>();
  final refresher = RefreshController();
  final pageController = PageController();
  final banners = <String>[].obs;

  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  @override
  void onClose() {
    super.onClose();
    _autoScrollTimer?.cancel();
  }

  Future onRefresh() async {
    await getBanner();
    SessionManager.shared.getAppVersion();
  }

  Future getBanner() async {
    final response = await InfoApi().getBanner();
    if (response.isSuccess) {
      banners.value = response.data.listValue
          .map((e) => e['image'].stringValue)
          .toList();
      startAutoScroll();
    }
    refresher.refreshCompleted();
  }

  void startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (banners.isEmpty) return;
      _currentPage = (_currentPage + 1) % banners.length;
      pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void onTapLoan() {
    LoanRoute.toProductList();
  }

  void onTapDigitalLoan() {
    LoanRoute.toDigitaLoanLimit();
  }

  void onTapSaving() {
    SavingRoute.toCreateCondition();
  }

  void onTapGold() {
    final index = tab.tabItems.indexWhere((e) => e.label == 'Алт');
    tab.tabIndex.value = index;
  }

  void onTapBanner(String value) {
    HomeBannerSheet(url: value).show();
  }
}
