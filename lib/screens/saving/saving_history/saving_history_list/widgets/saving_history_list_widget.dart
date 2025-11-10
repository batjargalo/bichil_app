import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SavingHistoryListWidget extends StatelessWidget {
  final SavingInfoModel model;
  final ValueChanged<SavingInfoModel> onTap;
  const SavingHistoryListWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () => onTap(model),
      child: IOCardBorderWidget(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              model.prodName,
              style: IOStyles.body2Semibold,
            ),
          ],
        ),
      ),
    );
  }
}
