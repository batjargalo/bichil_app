import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingStatementScreen extends GetView<SavingStatementController> {
  const SavingStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Obx(
        () => IOScaffold(
          appBar: IOAppBar(
            titleText: controller.titleText,
            hasCorner: false,
            bottom: IOTabBar(tabs: const [
              'Гүйлгээ',
              'Өгөөж',
            ]),
          ),
          body: controller.isInitialLoading.value
              ? const IOLoading()
              : TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SavingStatementWidget(
                      items: controller.outItems.toList(),
                    ),
                    SavingStatementWidget(
                      items: controller.inItems.toList(),
                    ),
                  ],
                ),
          bottomNavigationBar: IOBottomNavigationBar(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Эхлэх огноо',
                        style: IOStyles.body2Medium,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Дуусах огноо',
                        style: IOStyles.body2Medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: IODropdownWidget.custom(
                        model: controller.start,
                        onTap: controller.onTapStart,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: IODropdownWidget.custom(
                        model: controller.end,
                        onTap: controller.onTapEnd,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
