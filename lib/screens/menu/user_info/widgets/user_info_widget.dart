import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool hasAction;
  final VoidCallback? onTap;
  const UserInfoWidget({
    super.key,
    required this.title,
    required this.value,
    this.hasAction = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: IOStyles.body2Regular.copyWith(
                    color: IOColors.textSecondary,
                  ),
                ),
                Text(
                  value.isEmpty ? '-' : value,
                  style: IOStyles.body2Semibold,
                ),
              ],
            ),
          ),
          if (hasAction)
            GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    value.isEmpty ? 'Оруулах' : 'Солих',
                    style: IOStyles.button40.copyWith(
                      color: IOColors.brand500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
