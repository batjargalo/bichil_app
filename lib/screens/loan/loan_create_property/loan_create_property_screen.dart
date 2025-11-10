import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreatePropertyScreen extends GetView<LoanCreatePropertyController> {
  const LoanCreatePropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Зээл',
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: GestureDetector(
                  onTap: Get.focusScope?.unfocus,
                  child: SizedBox.expand(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          IOTextfieldWidget(model: controller.amount),
                          const SizedBox(height: 16),
                          const Text(
                            'Барьцаа хөрөнгийн төрөл',
                            style: IOStyles.body2Semibold,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: Row(
                              children: List.generate(
                                controller.types.length * 2 - 1,
                                (index) {
                                  if (index.isEven) {
                                    final e = controller.types[index ~/ 2];
                                    return Expanded(
                                      child: IOSelectButton(
                                        title: e,
                                        isSelected: controller.type.value == e,
                                        onTap: () => controller.type.value = e,
                                      ),
                                    );
                                  } else {
                                    return const SizedBox(width: 8);
                                  }
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (controller.type.value == 'Орон сууц') ...[
                            const Text(
                              'Өрөөны тоо',
                              style: IOStyles.body2Semibold,
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 40,
                              child: Row(
                                children: List.generate(
                                  controller.rooms.length * 2 - 1,
                                  (index) {
                                    if (index.isEven) {
                                      final e = controller.rooms[index ~/ 2];
                                      return Expanded(
                                        child: IOSelectButton(
                                          title: e,
                                          isSelected:
                                              controller.room.value == e,
                                          onTap: () =>
                                              controller.room.value = e,
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(width: 8);
                                    }
                                  },
                                ).toList(),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                          Visibility(
                            visible: controller.type.value == 'Хашаа байшин',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                IOTextfieldWidget(model: controller.landSize),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          IOTextfieldWidget(model: controller.size),
                          const SizedBox(height: 20),
                          const Text(
                            'Байршил',
                            style: IOStyles.body2Semibold,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: Row(
                              children: List.generate(
                                controller.countryItem.length * 2 - 1,
                                (index) {
                                  if (index.isEven) {
                                    final e =
                                        controller.countryItem[index ~/ 2];
                                    return Expanded(
                                      child: IOSelectButton(
                                        title: e.name,
                                        isSelected:
                                            controller.country.value.id == e.id,
                                        onTap: () =>
                                            controller.onSelectCountry(e),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox(width: 8);
                                  }
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          IOCardBorderWidget(
                            child: Column(
                              children: [
                                IODropdownWidget(
                                  model: controller.district,
                                  pickItems: controller.districtItem.toList(),
                                  onSelect: controller.onSelectDistrict,
                                ),
                                const Divider(
                                  height: 1,
                                ),
                                IODropdownWidget(
                                  model: controller.soum,
                                  pickItems: controller.soumItem.toList(),
                                  onSelect: controller.onTapSoum,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: IOBottomNavigationBar(
          backgroundColor: IOColors.backgroundPrimary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: IOColors.warningSecondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Та зөвхөн өөрийн өмчлөлийг барьцаалж зээл авах боломжтойг анхаарана уу.',
                  style: IOStyles.body2Regular.copyWith(
                    color: IOColors.warningPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              IOButtonWidget(
                onPressed: controller.onTapSend,
                model: controller.send.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
