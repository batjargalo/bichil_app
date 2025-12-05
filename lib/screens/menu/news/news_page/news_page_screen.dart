import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsPageScreen extends GetView<NewsPageController> {
  const NewsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Мэдээ мэдээлэл',
      ),
      body: DefaultTabController(
        length: controller.categories.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: IOColors.backgroundSecondary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TabBar(
                dividerHeight: 0,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: IOColors.brand50,
                  borderRadius: BorderRadius.circular(4),
                ),
                labelStyle: IOStyles.body2Semibold,
                unselectedLabelStyle: IOStyles.body2Semibold,
                labelColor: IOColors.infoPrimary,
                splashBorderRadius: BorderRadius.circular(4),
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                tabs: controller.categories
                    .map((e) => Tab(
                          text: e.title,
                        ))
                    .toList(),
              ),
            ),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  AdviceListScreen(),
                  NewsListScreen(),
                  VideoListScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
