import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorScreen extends GetView<CalculatorController> {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: IOScaffold(
        appBar: IOAppBar(
          hasCorner: false,
          titleText: controller.titleText,
          bottom: IOTabBar(tabs: const [
            'Зээл',
            'Итгэлцэл',
          ]),
        ),
        body: const TabBarView(
          children: [
            LoanCalculatorFormScreen(),
            SavingCalculatorFormScreen(),
          ],
        ),
        // appBar: IOAppBar(
        //   titleText: 'Тооцоолуур',
        // ),
        // body: const LoanCalculatorFormScreen(),
      ),
    );
  }
}
