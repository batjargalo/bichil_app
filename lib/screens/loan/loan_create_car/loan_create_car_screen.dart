import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateCarScreen extends GetView<LoanCreateCarController> {
  const LoanCreateCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Зээл',
        ),
        body: GestureDetector(
          onTap: Get.focusScope?.unfocus,
          child: SizedBox.expand(
            child: AbsorbPointer(
              absorbing: controller.isLoading.value,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Автомашины бүртгэлийн төрөл',
                      style: IOStyles.body1SemiBold,
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
                    const SizedBox(height: 24),
                    Visibility(
                      visible: controller.type.value == 'Улсын дугаартай',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Зээлийн төрөл',
                            style: IOStyles.body1SemiBold,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 40,
                            child: Row(
                              children: List.generate(
                                controller.loans.length * 2 - 1,
                                (index) {
                                  if (index.isEven) {
                                    final e = controller.loans[index ~/ 2];
                                    return Expanded(
                                      child: IOSelectButton(
                                        title: e,
                                        isSelected: controller.loan.value == e,
                                        onTap: () => controller.loan.value = e,
                                      ),
                                    );
                                  } else {
                                    return const SizedBox(width: 8);
                                  }
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(height: 24),
                          IOTextfieldWidget(model: controller.carNo),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.type.value == 'Гаалийн бичигтэй',
                      child: IOTextfieldWidget(
                        model: controller.frameNo,
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
