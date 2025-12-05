import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SavingCreateConfirmButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SavingCreateConfirmButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: onTap,
      child: IOCardBorderWidget(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: IOStyles.body2Semibold,
              ),
            ),
            SvgPicture.asset(
              'assets/icons/chevron.right.svg',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
