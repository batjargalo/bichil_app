import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';

class IORadio<T> extends StatelessWidget {
  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T>? onTap;
  const IORadio({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return IOGesture(
      onTap: selected ? null : () => onTap?.call(value),
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: IOStyles.body2Regular.copyWith(
                color: IOColors.textSecondary,
              ),
            ),
            Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(5),
              decoration: selected
                  ? const BoxDecoration(
                      color: IOColors.successPrimary,
                      shape: BoxShape.circle,
                    )
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 1, color: IOColors.textQuarternary)),
              child: selected
                  ? Container(
                      decoration: const BoxDecoration(
                        color: IOColors.backgroundPrimary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
