import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: TabBarAppBarWidget(
          count: controller.tab.notificationCount.value,
          name: controller.user.value.firstName,
          hasEye: false,
          onTapNotfication: controller.onTapNotfication,
        ),
        body: IORefresher(
          controller: controller.refresher,
          onRefresh: controller.onRefresh,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (controller.banners.isNotEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: PageView(
                          controller: controller.pageController,
                          children: controller.banners
                              .map(
                                (e) => IOGesture(
                                  onTap: () => controller.onTapBanner(e),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: IOImageNetworkWidget(
                                        url: e,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: controller.pageController,
                        count: controller.banners.length,
                        effect: const ExpandingDotsEffect(
                          dotWidth: 6,
                          dotHeight: 6,
                          dotColor: IOColors.brand100,
                          activeDotColor: IOColors.brand500,
                          spacing: 4,
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 185,
                        child: Row(
                          children: [
                            Expanded(
                              child: HomeWidget(
                                direction: Axis.vertical,
                                icon: 'noncoll.png',
                                title: 'Дижитал зээл',
                                description: 'Хурдан болон хялбар зээл',
                                onTap: controller.onTapDigitalLoan,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: HomeWidget(
                                direction: Axis.vertical,
                                icon: 'loan.home.png',
                                title: 'Барьцаатай зээл',
                                description:
                                    'Таны хэрэгцээнд нийцэх олон төрлийн зээл',
                                onTap: controller.onTapLoan,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      HomeWidget(
                        direction: Axis.horizontal,
                        icon: 'saving.home.png',
                        title: 'Итгэлцэл нээх',
                        description: 'Баталгаатай өсөн дэвших өндөр өгөөж',
                        onTap: controller.onTapSaving,
                      ),

                      const SizedBox(height: 8),
                      HomeWidget(
                        direction: Axis.horizontal,
                        icon: 'gold.home.png',
                        title: 'Алт',
                        description:
                            'Та алт худалдан авах, хэвлүүлэх, хуримтлуулах боломжтой',
                        onTap: controller.onTapGold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
