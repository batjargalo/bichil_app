import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class LoanPledgeTile extends StatelessWidget {
  const LoanPledgeTile({super.key, required this.model});

  final LoanPledgeUiModel model;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: ValueKey(model.headerCode),
      tilePadding: const EdgeInsets.fromLTRB(16, 2, 16, 2),
      childrenPadding: EdgeInsets.zero,
      collapsedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      title: Row(
        children: [
          Flexible(
            child: Text(
              model.headerCode,
              style: IOStyles.body2Bold.copyWith(color: IOColors.brand500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          Container(width: 1, height: 16, color: IOColors.brand500),
          const SizedBox(width: 6),
          Text(
            model.headerLabel,
            style: IOStyles.body2Bold.copyWith(color: IOColors.brand500),
          ),
        ],
      ),
      children: [
        const Divider(height: 1, thickness: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            children: model.fields
                .map((field) => LoanPledgeFieldRow(field: field))
                .toList(growable: false),
          ),
        ),
      ],
    );
  }
}
