import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan_tab/loan_tab.dart';
import 'package:flutter/material.dart';

class LoanDetail extends StatelessWidget {
  final LoanInfoModel loan;
  const LoanDetail({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Нийт үлдэгдэл',
                    style: IOStyles.caption2Regular.copyWith(
                      color: IOColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(loan.totalBal.toCurrency(), style: IOStyles.h6),
                ],
              ),
              _StatusBadge(isOver: loan.isOver),
            ],
          ),

          Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Олгосон зээл',
                    style: IOStyles.caption2Regular.copyWith(
                      color: IOColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loan.advAmount.toCurrency(),
                    style: IOStyles.caption1SemiBold,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Төлөлт хийх огноо',
                    style: IOStyles.caption2Regular.copyWith(
                      color: IOColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loan.nextSchdDate.toFormattedString(format: 'yyyy.MM.dd'),
                    style: IOStyles.caption1SemiBold,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Дараагийн төлөлт',
                    style: IOStyles.caption2Regular.copyWith(
                      color: IOColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loan.nextSchdTotal.toCurrency(),
                    style: IOStyles.caption1SemiBold,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    loan.isOver ? 'Хэтэрсэн өдөр' : 'Дараагийн төлөлт хүртэл',
                    style: IOStyles.caption2Regular.copyWith(
                      color: IOColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${loan.overdueDayCount == 0 ? DateTime.tryParse(loan.nextSchdDate)?.add(Duration(days: 1)).difference(DateTime.now()).inDays ?? 0 : loan.overdueDayCount} өдөр',
                    style: IOStyles.caption1SemiBold,
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ), // Placeholder for alignment
            ],
          ),
        ],
      ),
    );
    // IOCardBorderWidget(
    //   child: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(16),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             const Text('Зээлийн төрөл', style: IOStyles.caption1Regular),
    //             const SizedBox(height: 8),
    //             Text(loan.prodName, style: IOStyles.body1SemiBold),
    //           ],
    //         ),
    //       ),
    //       const Divider(height: 1, thickness: 1),
    //       Padding(
    //         padding: const EdgeInsets.all(16),
    //         child:
    //       ),
    //     ],
    //   ),
    // );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isOver;

  const _StatusBadge({required this.isOver});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isOver
            ? IOColors.errorPrimary.withAlpha(30)
            : IOColors.successPrimary.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isOver ? 'Хугацаа хэтэрсэн' : 'Хэвийн',
        style: IOStyles.caption2SemiBold.copyWith(
          color: isOver ? IOColors.errorPrimary : IOColors.successPrimary,
        ),
      ),
    );
  }
}

class RowWidgets extends StatelessWidget {
  final String title;
  final String value;

  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const RowWidgets({
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
        Text(title, style: titleStyle ?? IOStyles.caption1Regular),
        const SizedBox(width: 16),
        Flexible(
          child: Text(value, style: valueStyle ?? IOStyles.caption1Bold),
        ),
      ],
    );
  }
}
