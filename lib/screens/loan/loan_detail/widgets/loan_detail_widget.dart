import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan_tab/loan_tab.dart';
import 'package:flutter/material.dart';

class LoanDetailWidget extends StatelessWidget {
  final LoanInfoModel loan;
  const LoanDetailWidget({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Зээлийн төрөл',
                  style: IOStyles.caption1Regular,
                ),
                const SizedBox(height: 8),
                Text(
                  loan.prodName,
                  style: IOStyles.body1SemiBold,
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                RowWidget(
                  title: 'Эдийн засагч',
                  value: loan.acntManagerName,
                ),
                const SizedBox(height: 16),
                RowWidget(
                  title: 'Олгосон зээл',
                  value: loan.advAmount.toCurrency(),
                ),
                const SizedBox(height: 16),
                RowWidget(
                  title: 'Хүү (жилээр)',
                  value: '${loan.baseFixedIntRate}%',
                ),
                const SizedBox(height: 16),
                RowWidget(
                  title: 'Хугацаа',
                  value: '${loan.termLen} ${loan.termBasis.title}',
                ),
                const SizedBox(height: 16),
                RowWidget(
                  title: 'Эхэлсэн огноо',
                  value: loan.startDate.toFormattedString(
                    hasLocalTimeZone: false,
                    format: 'yyyy/MM/dd',
                  ),
                ),
                const SizedBox(height: 16),
                RowWidget(
                  title: 'Дуусах огноо',
                  value: loan.endDate.toFormattedString(
                    hasLocalTimeZone: false,
                    format: 'yyyy/MM/dd',
                  ),
                ),
                if (loan.status == 'C') ...[
                  const SizedBox(height: 16),
                  RowWidget(
                    title: 'Төлөв',
                    value: loan.statusName,
                    valueStyle: IOStyles.caption1Bold.copyWith(
                      color: IOColors.successPrimary,
                    ),
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  final String title;
  final String value;

  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const RowWidget({
    super.key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ?? IOStyles.caption1Regular,
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            style: valueStyle ?? IOStyles.caption1Bold,
          ),
        ),
      ],
    );
  }
}
