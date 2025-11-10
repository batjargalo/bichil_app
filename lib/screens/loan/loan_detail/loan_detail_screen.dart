import 'package:bichil/library/library.dart';

import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanDetailScreen extends GetView<LoanDetailController> {
  const LoanDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Дэлгэрэнгүй',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 16 + Get.mediaQuery.padding.bottom,
        ),
        child: Obx(
          () => Column(
            children: [
              LoanDetailWidget(loan: controller.loan),
              const SizedBox(height: 16),
              LoanDetailListWidget(
                actions: controller.actions,
                onTap: controller.onTapAction,
              ),
              if (controller.pledgeList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: LoanDetailListWidget(
                    actions: controller.pledge,
                    onTap: controller.onTapAction,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
