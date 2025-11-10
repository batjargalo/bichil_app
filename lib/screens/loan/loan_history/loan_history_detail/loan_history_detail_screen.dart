import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanHistoryDetailScreen extends GetView<LoanHistoryDetailController> {
  const LoanHistoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Зээлийн дэлгэрэнгүй',
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : controller.info.value == null
                ? IOEmptyWidget(
                    text: controller.errorMessage.value,
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        LoanDetailWidget(loan: controller.info.value!),
                      ],
                    ),
                  ),
      ),
    );
  }
}
