import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdviceListScreen extends StatelessWidget {
  const AdviceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      autoRemove: false,
      init: AdviceListController(),
      builder: (controller) {
        return Obx(
          () => controller.isInitialLoading.value
              ? const IOLoading()
              : IORefresher(
                  controller: controller.refresher,
                  onRefresh: controller.onRefresh,
                  onLoading: controller.onLoad,
                  child: ListView.separated(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    itemCount: controller.news.length,
                    itemBuilder: (context, index) {
                      final item = controller.news[index];
                      return index == 0
                          ? NewsListFirstWidget(
                              news: item, onTap: controller.onTap)
                          : NewsListWidget(news: item, onTap: controller.onTap);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                ),
        );
      },
    );
  }
}
