import 'package:bichil/library/theme/io_colors.dart';
import 'package:bichil/library/theme/io_styles.dart';
import 'package:bichil/screens/loan/loan_pledge/loan_pledge_list/models/loan_pledge_ui_model.dart';
import 'package:flutter/material.dart';

class LoanPledgeFieldRow extends StatelessWidget {
  const LoanPledgeFieldRow({super.key, required this.field});

  final LoanPledgeUiField field;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              field.label,
              style: IOStyles.caption1Medium.copyWith(
                color: IOColors.textTertiary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              field.value,
              textAlign: TextAlign.right,
              style: IOStyles.body2Semibold.copyWith(
                color: IOColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
