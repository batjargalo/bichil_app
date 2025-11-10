import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateFormScreen extends GetView<LoanCreateFormController> {
  const LoanCreateFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Зээл авах хүсэлт',
        ),
        body: controller.isInitialLoading.value
            ? const IOLoading()
            : AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Та мэдээллээ оруулна уу.',
                        style: IOStyles.h6,
                      ),
                      const SizedBox(height: 24),
                      IOTextfieldWidget(model: controller.lastName),
                      const SizedBox(height: 16),
                      IOTextfieldWidget(model: controller.firstName),
                      const SizedBox(height: 16),
                      IOTextfieldWidget(model: controller.phone),
                      const SizedBox(height: 16),
                      IOTextfieldWidget(model: controller.email),
                      if (controller.isCarLoan) ...[
                        const SizedBox(height: 16),
                        IOTextfieldWidget(model: controller.car),
                        const SizedBox(height: 4),
                        Text(
                          'Та өөрийн нэр дээрх автомашиныг барьцаалж зээл авах боломжтойг анхаарна уу.',
                          style: IOStyles.caption2Medium.copyWith(
                            color: IOColors.warningPrimary,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      IODropdownWidget(
                        model: controller.branch,
                        pickItems: controller.branches.toList(),
                        onSelect: controller.onSelectBranches,
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: IOBottomNavigationBar(
          child: IOButtonWidget(
            model: controller.button.value,
            onPressed: controller.senRequest,
          ),
        ),
      ),
    );
  }
}
