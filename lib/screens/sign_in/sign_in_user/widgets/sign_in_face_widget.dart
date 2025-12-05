import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';

class SignInFaceWidget extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool> onTap;
  const SignInFaceWidget({
    super.key,
    required this.checked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () {
        onTap(!checked);
      },
      child: IOCardBorderWidget(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        borderColor: IOColors.brand100,
        backgroundColor: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Хэрэглэгчээр сануулах',
              style: IOStyles.body2Regular.copyWith(
                color: IOColors.textPrimary,
              ),
            ),
            SizedBox.square(
              dimension: 16,
              child: IOCheckbox(
                value: checked,
                onChanged: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
