import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoldTabScreen extends GetView<GoldTabController> {
  const GoldTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: TabBarAppBarWidget(
          count: controller.tab.notificationCount.value,
          name: controller.user.value.firstName,
          hasEye: false,
          onTapNotfication: controller.onTapNotfication,
        ),
        body: const Center(child: IOEmptyWidget(text: 'Тун удахгүй...')),
      ),
    );
  }
}
