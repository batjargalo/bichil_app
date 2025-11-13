import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import 'digital_loan_create_contract_controller.dart';

class DigitalLoanContractScreen extends GetView<DigitalLoanContractController> {
  const DigitalLoanContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: "Зээлийн гэрээ"),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: HtmlWidget(controller.html.value, textStyle: IOStyles.body2Regular),
              ),
      ),
    );
  }
}
