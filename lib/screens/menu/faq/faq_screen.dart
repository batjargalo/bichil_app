import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqScreen extends GetView<FaqController> {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: IOScaffold(
        appBar: IOAppBar(
          hasCorner: false,
          titleText: 'Түгээмэл асуулт хариулт',
          bottom: IOTabBar(
            tabs: const [
              'Зээлтэй холбоотой',
              'Апп-тай холбоотой',
            ],
          ),
        ),
        body: Obx(
          () => controller.isInitialLoading.value
              ? const IOLoading()
              : TabBarView(
                  children: [
                    controller.loanItems.isEmpty
                        ? const IOEmptyWidget()
                        : ListView.separated(
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) {
                              final item = controller.loanItems[index];
                              return FaqItemWidget(model: item);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 12);
                            },
                            itemCount: controller.loanItems.length,
                          ),
                    controller.appItems.isEmpty
                        ? const IOEmptyWidget()
                        : ListView.separated(
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) {
                              final item = controller.appItems[index];
                              return FaqItemWidget(model: item);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 12);
                            },
                            itemCount: controller.appItems.length,
                          )
                  ],
                ),
        ),
      ),
    );
  }
}
