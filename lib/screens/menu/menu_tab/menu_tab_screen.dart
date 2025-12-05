import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuTabScreen extends GetView<MenuTabController> {
  const MenuTabScreen({super.key});

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
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (controller.isLogged) ...[
                      MenuTabUserWidget(
                        user: controller.user.value,
                        onTap: controller.onTapUser,
                      ),
                      const SizedBox(height: 16),
                    ],
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final model = controller.items[index];
                        return MenuTabWidget(
                          model: model,
                          onTap: controller.onTapItem,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                      itemCount: controller.items.length,
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder(
                      future: HelperManager.version,
                      builder: (_, snapshot) {
                        return Text(
                          snapshot.data ?? '',
                          textAlign: TextAlign.center,
                          style: IOStyles.body1Medium,
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    controller.isLogged
                        ? IOButtonWidget(
                            model: controller.logoutButton,
                            onPressed: controller.onTapLogout,
                          )
                        : IOButtonWidget(
                            model: controller.signInButton,
                            onPressed: controller.onTapSignIn,
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
