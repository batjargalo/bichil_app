import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingTabScreen extends GetView<SavingTabController> {
  const SavingTabScreen({super.key});

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: controller.isInitialLoading.value
                  ? const IOLoading()
                  : IORefresher(
                      controller: controller.refresher,
                      onRefresh: controller.onRefresh,
                      child: controller.items.isEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: IOEmptyWidget(
                                icon: IOIconModel(
                                  type: IOIconType.svg,
                                  icon: 'coin.pig.empty.svg',
                                ),
                                text: controller.isLogged
                                    ? 'Та итгэлцэлгүй байна.'
                                    : 'Та нэвтэрж орсноор итгэлцлийн мэдээллээ харах боломжтой.',
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, index) {
                                final item = controller.items[index];
                                return SavingTabItemWidget(
                                  isSecure: controller.isSecure.value,
                                  item: item,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16);
                              },
                              itemCount: controller.items.length,
                            ),
                    ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
                top: 8,
              ),
              decoration: const BoxDecoration(
                color: IOColors.backgroundSecondary,
                boxShadow: [
                  BoxShadow(
                    color: IOColors.backgroundSecondary,
                    offset: Offset(0, -1),
                    blurRadius: 5,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: IOButtonWidget(
                model: controller.add,
                onPressed: controller.onTapAdd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
