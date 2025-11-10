import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class SavingCreateContractScreen
    extends GetView<SavingCreateContractController> {
  const SavingCreateContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.type.title,
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: HtmlWidget(
                  controller.html.value,
                  textStyle: IOStyles.body2Regular,
                ),
              ),
      ),
    );
  }
}
