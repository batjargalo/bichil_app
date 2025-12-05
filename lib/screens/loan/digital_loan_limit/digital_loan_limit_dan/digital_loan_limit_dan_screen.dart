import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DigitalLoanLimitDanScreen extends GetView<DigitalLoanLimitDanController> {
  const DigitalLoanLimitDanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: 'ДАН нэвтрэлт'),
      body: Obx(
        () => Stack(
          fit: StackFit.expand,
          children: [
            WebViewWidget(controller: controller.webController),
            if (controller.isInitialLoading.value) const IOLoading(),
          ],
        ),
      ),
    );
  }
}
