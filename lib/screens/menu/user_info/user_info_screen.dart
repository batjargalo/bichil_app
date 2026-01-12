import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoScreen extends GetView<UserInfoController> {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: 'Хэрэглэгчийн мэдээлэл'),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: 24 + Get.mediaQuery.padding.bottom,
          ),
          child: Column(
            children: [
              IOCardBorderWidget(
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
              const SizedBox(height: 24),
              IOCardBorderWidget(
                child: Column(
                  children: [
                    ...List.generate(controller.relatedPersons.length, (index) {
                      final person = controller.relatedPersons[index];
                      return Column(
                        children: [
                          UserRelatedInfoWidget(
                            relation: person.relation,
                            name: person.name,
                            phone: person.phone,
                            hasAction: true,
                            onTap: () => controller.onChangeRelate(person),
                          ),
                          if (index < controller.relatedPersons.length - 1)
                            const Divider(height: 1, thickness: 1),
                        ],
                      );
                    }),
                    if (controller.relatedPersons.length < 3)
                      const Divider(height: 1, thickness: 1),
                    ...List.generate(3 - controller.relatedPersons.length, (
                      index,
                    ) {
                      return Column(
                        children: [
                          UserRelatedInfoWidget(
                            relation: '',
                            name: '',
                            phone: '',
                            hasAction: true,
                            onTap: () => controller.onChangeRelate(
                              UserRelatedModel(
                                id: 0,
                                name: '',
                                relation: '',
                                phone: '',
                                isActive: false,
                              ),
                            ),
                          ),
                          if (index < 3 - controller.relatedPersons.length - 1)
                            const Divider(height: 1, thickness: 1),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
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
