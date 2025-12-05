import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QpayScreen extends GetView<QpayController> {
  const QpayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: controller.model.title,
        ),
        body: AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                QpayInfoWidget(info: controller.model.info),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  children: controller.model.urls
                      .map(
                        (e) => QpayItemWidget(
                          url: e,
                          onTap: controller.onCheck,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          child: IOButtonWidget(
            model: controller.check.value,
            onPressed: controller.checkPayment,
          ),
        ),
      ),
    );
  }
}
