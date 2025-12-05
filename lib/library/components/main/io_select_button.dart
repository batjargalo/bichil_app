import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';

class IOSelectButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const IOSelectButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? IOColors.brand50 : IOColors.backgroundPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: isSelected ? IOColors.brand500 : IOColors.strokePrimary,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: IOStyles.caption1SemiBold,
        ),
      ),
    );
  }
}
