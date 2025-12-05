import 'package:bichil/library/library.dart';
import 'package:bichil/screens/saving/saving_detail/widgets/saving_detail_list_widget.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingDetailScreen extends GetView<SavingDetailController> {
  const SavingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Дэлгэрэнгүй',
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 16 + Get.mediaQuery.padding.bottom,
                ),
                child: Column(
                  children: [
                    SavingDetailWidget(detail: controller.detail.value),
                    const SizedBox(height: 16),
                    SavingDetailListWidget(
                      actions: controller.action1,
                      onTap: controller.onTapAction,
                    ),
                    const SizedBox(height: 16),
                    SavingDetailListWidget(
                      actions: controller.action2,
                      onTap: controller.onTapAction,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
