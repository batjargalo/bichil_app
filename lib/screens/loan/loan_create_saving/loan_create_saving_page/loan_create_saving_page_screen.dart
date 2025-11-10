import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateSavingPageScreen
    extends GetView<LoanCreateSavingPageController> {
  const LoanCreateSavingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      resizeToAvoidBottomInset: false,
      appBar: IOAppBar(
        titleText: controller.title,
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: IOPageIndicator(
                      controller: controller.pageController,
                      count: controller.screens.length,
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      children: controller.screens,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
