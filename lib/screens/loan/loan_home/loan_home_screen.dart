import 'package:bichil/library/components/main/io_appbar.dart';
import 'package:bichil/library/components/main/io_scaffold.dart';
import 'package:bichil/library/components/main/io_tabbar.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanHomeScreen extends GetView<LoanHomeController> {
  const LoanHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: IOScaffold(
        appBar: IOAppBar(
          hasCorner: false,
          titleText: 'Зээл',
          bottom: IOTabBar(tabs: const ['Зээлийн бүтээгдэхүүн', 'Миний зээл']),
        ),
        body: const TabBarView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [LoanProductScreen(), LoanTabScreen()],
        ),
      ),
    );
  }
}

class LoanHomeScreesn extends GetView<LoanHomeController> {
  const LoanHomeScreesn({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: TabBarAppBarWidget(
          count: controller.tab.notificationCount.value,
          name: controller.user.value.firstName,
          hasEye: true,
          isEyeOn: !controller.isSecure.value,
          onTapEye: controller.onTapEye,
          onTapNotfication: controller.onTapNotfication,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1C3AED),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTabButton(context, 'Зээлийн бүтээгдэхүүн', true),
                      _buildTabButton(context, 'Миний зээл', false),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTabButton(BuildContext context, String label, bool selected) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.blue : Colors.white,
          fontSize: 16,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    ),
  );
}
