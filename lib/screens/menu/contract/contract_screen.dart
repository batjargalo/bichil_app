import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

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
          child: Html(
            data: controller.html.value,
            extensions: [TableHtmlExtension()],
          ),
        ),
      ),
    );
  }
}
