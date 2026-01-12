import 'package:bichil/library/theme/io_colors.dart';
import 'package:flutter/material.dart';

class LoanDurationWidgetTile extends StatelessWidget {
  const LoanDurationWidgetTile({
    super.key,
    required this.duration,
    this.isSelected = false,
  });

  final String duration;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        key: key,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(176, 198, 234, 1).withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            duration,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: isSelected ? IOColors.brand500 : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
