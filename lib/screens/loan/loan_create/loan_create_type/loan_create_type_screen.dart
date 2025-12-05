import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateTypeScreen extends GetView<LoanCreateTypeController> {
  const LoanCreateTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Зээл авах хүсэлт',
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Text(
                'Та зээлийн бүтээгдэхүүн сонгоно уу',
                style: IOStyles.h6,
              ),
            ),
            Expanded(
              child: controller.isInitialLoading.value
                  ? const IOLoading()
                  : ListView.separated(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16 + Get.mediaQuery.padding.bottom,
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.items[index];
                        return LoanCreateTypeWidget(
                          model: item,
                          onTap: controller.onTap,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                      itemCount: controller.items.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
