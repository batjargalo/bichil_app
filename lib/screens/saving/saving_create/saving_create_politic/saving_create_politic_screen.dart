import 'package:bichil/library/components/components.dart';
import 'package:bichil/library/theme/theme.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingCreatePoliticScreen extends GetView<SavingCreatePoliticController> {
  const SavingCreatePoliticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(
          titleText: 'Итгэлцэл нээх',
        ),
        body: AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Та улс төрийн нөлөө бүхий этгээдтэй хамааралтай эсэх?',
                  style: IOStyles.body2Semibold,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _Button(
                        title: 'Үгүй',
                        selected: controller.relatedPerson.value == false,
                        onTap: () => controller.onTapPerson(false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _Button(
                        title: 'Тийм',
                        selected: controller.relatedPerson.value == true,
                        onTap: () => controller.onTapPerson(true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Таны байршуулж буй мөнгөн хөрөнгө улс төрийн нөлөө бүхий этгээдтэй хамааралтай эсэх?',
                  style: IOStyles.body2Semibold,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _Button(
                        title: 'Үгүй',
                        selected: controller.relatedMoney.value == false,
                        onTap: () => controller.onTapMoney(false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _Button(
                        title: 'Тийм',
                        selected: controller.relatedMoney.value == true,
                        onTap: () => controller.onTapMoney(true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          child: IOButtonWidget(
            model: controller.next.value,
            onPressed: controller.onTapNext,
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  const _Button({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor:
              selected ? IOColors.brand50 : IOColors.backgroundPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            width: 1,
            color: selected ? IOColors.brand500 : IOColors.strokePrimary,
          ),
        ),
        child: Text(
          title,
          style: IOStyles.caption1SemiBold,
        ),
      ),
    );
  }
}
