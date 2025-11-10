import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoanHomeController extends IOController {
  final tab = Get.find<TabBarController>();
  final pageController = PageController();
  final refresher = RefreshController();

  // final loans = <LoanInfoModel>[].obs;
  // final loan = Rx<LoanInfoModel?>(null);
  final isSecure = HelperManager.isSecureLoan.obs;

  final add = IOButtonModel(
    label: 'Зээлийн хүсэлт илгээх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    suffixIcon: 'add.svg',
  );
  TabController? tabController;
  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  void onTapAdd() {
    LoanRoute.toProductList();
  }

  void setTabController(TabController controller) {
    tabController = controller;
    tabController?.addListener(() {});
  }

  void switchToTab(int index) {
    tabController?.animateTo(index);
  }

  Future onRefresh() async {
    if (HelperManager.isLogged) {
      await getLoanList();
      refresher.refreshCompleted();
    }
  }

  Future getLoanList() async {
    // final response = await LoanApi().getLoanList();

    // if (response.isSuccess) {
    //   loans.value = response.data.listValue
    //       .map((e) => LoanInfoModel.fromJson(e))
    //       .toList();
    //   loan.value = loans.firstWhereOrNull((e) => e.canTakeLoan);
    // }
  }

  Future onTapEye() async {
    await UserStoreManager.shared.write(kSecureLoan, !isSecure.value);
    isSecure.value = HelperManager.isSecureLoan;
  }
}
