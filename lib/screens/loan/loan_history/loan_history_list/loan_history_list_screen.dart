import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanHistoryListScreen extends GetView<LoanHistoryListController> {
  const LoanHistoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : controller.items.isEmpty
                ? IORefresher(
                    controller: controller.refresher,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoad,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: IOEmptyWidget(
                        icon: IOIconModel(
                          type: IOIconType.svg,
                          icon: 'coin.flower.empty.svg',
                        ),
                        text: 'Та зээлийн түүхгүй байна.',
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final item = controller.items[index];
                      return LoanHistoryListWidget(
                        model: item,
                        onTap: controller.onTapItem,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                    itemCount: controller.items.length,
                  ),
      ),
    );
  }
}
