import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SavingCalculatorResultWidget extends StatelessWidget {
  final SavingCalculatorModel model;
  const SavingCalculatorResultWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _RowItem(
            title: 'Байршуулах мөнгөн дүн',
            value: model.amount.toDouble().toCurrency(),
          ),
          const SizedBox(height: 8),
          _RowItem(
            title: '${model.period.title}д авах нийт өгөөж',
            value: model.totalAmount.toDouble().toCurrency(),
          ),
          const SizedBox(height: 8),
          _RowItem(
            title: 'Өгөөж авах давтамж',
            value: model.frequency.title,
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final String title;
  final String value;

  const _RowItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: IOStyles.caption1Regular.copyWith(
            color: IOColors.textTertiary,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: IOStyles.caption1Bold,
          ),
        ),
      ],
    );
  }
}
