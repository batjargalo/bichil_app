import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class NewsDetailScreen extends GetView<NewsDetailController> {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Мэдээ',
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: 16 + Get.mediaQuery.padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        controller.info.value.title,
                        style: IOStyles.body1Bold.copyWith(
                          color: IOColors.brand500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        controller.info.value.publishedDate.toFormattedString(
                          format: 'yyyy-MM-dd',
                        ),
                        style: IOStyles.caption1Regular.copyWith(
                          color: IOColors.textTertiary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 220,
                      child: IOImageNetworkWidget(
                        url: controller.info.value.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: HtmlWidget(
                        controller.info.value.content,
                        textStyle: IOStyles.body2Regular,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
