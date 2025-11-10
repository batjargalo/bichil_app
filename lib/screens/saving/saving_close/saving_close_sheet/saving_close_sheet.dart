import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SavingCloseSheet extends StatelessWidget {
  const SavingCloseSheet({super.key});

  Future<SavingCloseType?> show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: IOColors.textTertiary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: IOCardBorderWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Row(
                      title: SavingCloseType.deposite.title,
                      onTap: () => Get.back(result: SavingCloseType.deposite),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    _Row(
                      title: SavingCloseType.close.title,
                      onTap: () => Get.back(result: SavingCloseType.close),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _Row({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: IOStyles.body1SemiBold,
              ),
            ),
            const SizedBox(width: 16),
            SvgPicture.asset(
              'assets/icons/chevron.right.svg',
            ),
          ],
        ),
      ),
    );
  }
}

enum SavingCloseType {
  deposite(title: 'Хэсэгчилж авах'),
  close(title: 'Итгэлцэл хаах');

  const SavingCloseType({required this.title});

  final String title;
}
