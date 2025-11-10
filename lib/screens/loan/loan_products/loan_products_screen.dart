import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanProductsScreen extends GetView<LoanProductsController> {
  const LoanProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: 'Зээлийн хүсэлт илгээх'),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : IORefresher(
                controller: controller.refresher,
                onRefresh: controller.onRefresh,
                child: GridView.count(
                  padding: const EdgeInsets.all(16),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  children: controller.products
                      .map((e) => LoanTabProductWidget(item: e))
                      .toList(),
                ),
              ),
      ),
    );
  }
}
