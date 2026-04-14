import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class ContractScreen extends GetView<ContractController> {
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(titleText: 'Зээлийн гэрээ'),
        backgroundColor: IOColors.backgroundPrimary,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: HtmlWidget(controller.html.value, textStyle: IOStyles.body2Regular),
        ),
      ),
    );
  }
}
