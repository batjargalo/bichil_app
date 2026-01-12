import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoanAccountDialog extends StatelessWidget {
  const LoanAccountDialog({super.key});

  Future<bool?> show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: IOColors.textQuarternary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Анхаарна уу?',
                textAlign: TextAlign.center,
                style: IOStyles.h6,
              ),
              const SizedBox(height: 16),
              Text(
                'Та хувийн мэдээлэл хэсэгт өөрийн дансаа хадгална уу',
                textAlign: TextAlign.center,
                style: IOStyles.body1Medium.copyWith(
                  color: IOColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              IOButtonWidget(
                onPressed: () => Get.back(result: true),
                model: IOButtonModel(
                  label: 'Данс холбох',
                  type: IOButtonType.primary,
                  size: IOButtonSize.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
