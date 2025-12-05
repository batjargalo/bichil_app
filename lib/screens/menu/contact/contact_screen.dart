import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends GetView<ContactController> {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ContactSectionWidget(
                      title: 'Холбоо барих',
                    ),
                    ContactSocialWidget(
                      items: controller.info.toList(),
                      onTap: controller.onTapAction,
                    ),
                    const ContactSectionWidget(
                      title: 'Cошиал хаяг',
                    ),
                    ContactSocialWidget(
                      items: controller.social.toList(),
                      onTap: controller.onTapAction,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
