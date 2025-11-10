import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoScreen extends GetView<UserInfoController> {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Хэрэглэгчийн мэдээлэл',
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: 24 + Get.mediaQuery.padding.bottom,
          ),
          child: IOCardBorderWidget(
            child: Column(
              children: [
                UserInfoWidget(
                  title: 'Овог',
                  value: controller.user.value.lastName,
                ),
                const Divider(height: 1, thickness: 1),
                UserInfoWidget(
                  title: 'Нэр',
                  value: controller.user.value.firstName,
                ),
                const Divider(height: 1, thickness: 1),
                UserInfoWidget(
                  title: 'Регистр',
                  value: controller.user.value.registerCode,
                ),
                const Divider(height: 1, thickness: 1),
                UserInfoWidget(
                  title: 'Утасны дугаар',
                  value: controller.user.value.phone,
                  hasAction: true,
                  onTap: controller.onChangePhone,
                ),
                const Divider(height: 1, thickness: 1),
                UserInfoWidget(
                  title: 'Дансны дугаар',
                  value:
                      '${controller.user.value.bankAccount} - ${controller.user.value.bankName}',
                  hasAction: true,
                  onTap: controller.onChangeBank,
                ),
                const Divider(height: 1, thickness: 1),
                UserInfoWidget(
                  title: 'Имэйл хаяг',
                  value: controller.user.value.email,
                  hasAction: true,
                  onTap: controller.onChangeEmail,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: IOBottomNavigationBar(
        child: IOButtonWidget(
          model: controller.deleteButton,
          onPressed: controller.onTapDelete,
        ),
      ),
    );
  }
}
