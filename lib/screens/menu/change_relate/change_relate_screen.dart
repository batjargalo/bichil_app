import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeRelateScreen extends GetView<ChangeRelateController> {
  const ChangeRelateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(titleText: 'Ойр дотны хүний мэдээлэл'),
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
                        children: [
                          IODropdownWidget.custom(
                            model: controller.selectRelation,
                            onTap: controller.onTapSelect,
                          ),
                          const SizedBox(height: 16),
                          IOTextfieldWidget(model: controller.name),
                          const SizedBox(height: 16),
                          IOTextfieldWidget(model: controller.phone),
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
              IOButtonWidget(
                model: controller.save.value,
                onPressed: controller.person.id != 0
                    ? controller.onTapUpdate
                    : controller.onTapSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
