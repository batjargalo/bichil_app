import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:flutter/material.dart';

class LoanCalculatorResultHeaderWidget extends StatelessWidget {
  final LoanCalculatorModel model;
  const LoanCalculatorResultHeaderWidget({
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
            title: 'Зээлийн дүн',
            value: model.amount.toDouble().toCurrency(),
          ),
          const SizedBox(height: 8),
          _RowItem(
            title: 'Зээлийн хүү',
            value: '${model.rate}%',
          ),
          const SizedBox(height: 8),
          _RowItem(
            title: 'Хугацаа',
            value: '${model.month} сар',
          ),
          const SizedBox(height: 8),
          _RowItem(
            title: 'Эргэн төлөлтийн нөхцөл',
            value: model.type.title,
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
