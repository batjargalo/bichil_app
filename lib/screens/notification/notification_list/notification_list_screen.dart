import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationListScreen extends StatelessWidget {
  final NotificationType type;
  const NotificationListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationListController>(
      autoRemove: false,
      tag: type.toString(),
      init: NotificationListController(type: type),
      builder: (controller) {
        return Obx(
          () => IORefresher(
            controller: controller.refresher,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoad,
            child: controller.items.isEmpty
                ? const IOEmptyWidget(
                    text: 'Танд мэдэгдэл ирээгүй байна',
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(
                      bottom: Get.mediaQuery.padding.bottom,
                    ),
                    itemBuilder: (context, index) {
                      final item = controller.items[index];
                      return switch (type) {
                        NotificationType.private => NotificationPrivateWidget(
                            model: item,
                            onTap: controller.onTapItem,
                          ),
                        NotificationType.news => NotificationNewsWidget(
                            model: item,
                            onTap: controller.onTapItem,
                          ),
                      };
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1, thickness: 1);
                    },
                    itemCount: controller.items.length,
                  ),
          ),
        );
      },
    );
  }
}
