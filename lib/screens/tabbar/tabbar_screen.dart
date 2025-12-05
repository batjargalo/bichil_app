import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class TabBarScreen extends GetView<TabBarController> {
  static const routeName = '/TabBarScreen';
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: controller.tabItems.map((e) => e.screen).toList(),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: IOColors.strokePrimary,
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: BottomNavigationBar(
              backgroundColor: IOColors.backgroundPrimary,
              currentIndex: controller.tabIndex.value,
              onTap: controller.tabIndex.call,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: IOStyles.caption1Bold,
              unselectedLabelStyle: IOStyles.caption1Regular,
              selectedItemColor: IOColors.brand500,
              unselectedItemColor: IOColors.textTertiary,
              items: controller.tabItems
                  .map(
                    (e) => BottomNavigationBarItem(
                      label: e.label,
                      activeIcon: SvgPicture.asset(
                        'assets/icons/${e.icon}',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          e.activeColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      icon: SvgPicture.asset(
                        'assets/icons/${e.icon}',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          e.color,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
