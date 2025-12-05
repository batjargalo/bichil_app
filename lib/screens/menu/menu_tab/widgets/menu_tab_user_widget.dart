import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuTabUserWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  const MenuTabUserWidget({
    super.key,
    required this.user,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    user.fullName,
                    style: IOStyles.body1Bold,
                  ),
                  Text(
                    'Хувийн мэдээлэл харах',
                    style: IOStyles.body2Regular.copyWith(
                      color: IOColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              'assets/icons/chevron.right.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                IOColors.textPrimary,
                BlendMode.srcIn,
              ),
            )
          ],
        ),
      ),
    );
  }
}
