import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuLeftWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const MenuLeftWidget({
    super.key,
    required this.icon,
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
            SvgPicture.asset(
              'assets/icons/$icon',
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(
                IOColors.brand500,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: IOStyles.body2Semibold.copyWith(
                color: IOColors.textSecondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
