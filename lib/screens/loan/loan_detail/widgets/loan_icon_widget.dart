import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan_tab/loan_tab.dart';
import 'package:flutter/material.dart';

class LoanIcon extends StatelessWidget {
  final LoanInfoModel loan;
  final Function(int) action;
  final int activeIconIndex;
  const LoanIcon({
    super.key,
    required this.loan,
    required this.action,
    required this.activeIconIndex,
  });

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => action(0),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: activeIconIndex == 0
                          ? IOColors.brand600.withAlpha(30)
                          : Colors.transparent,
                    ),
                    child: Icon(
                      Icons.calendar_month,
                      size: 35,
                      color: IOColors.brand600,
                    ),
                  ),
                  Text(
                    'Хуваарь',
                    style: IOStyles.caption2Regular.copyWith(
                      color: activeIconIndex == 0
                          ? IOColors.brand600
                          : IOColors.brand300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => action(1),
              child: Column(
                children: [
                  Container(
                    width: 50, // Adjust size as needed
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Rounded corners for rectangle
                      color: activeIconIndex == 1
                          ? IOColors.brand600.withAlpha(30)
                          : Colors.transparent,
                    ),
                    child: Icon(
                      Icons.money,
                      size: 35,
                      color: IOColors.brand600,
                    ),
                  ),
                  Text(
                    'Зээл хаах',
                    style: IOStyles.caption2Regular.copyWith(
                      color: activeIconIndex == 1
                          ? IOColors.brand600
                          : IOColors.brand300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => action(2),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: activeIconIndex == 2
                          ? IOColors.brand600.withAlpha(30)
                          : Colors.transparent,
                    ),
                    child: Icon(
                      Icons.more_time,
                      size: 35,
                      color: loan.isOver
                          ? IOColors.brand600
                          : IOColors.brand300,
                    ),
                  ),
                  Text(
                    'Сунгалт',
                    style: IOStyles.caption2Regular.copyWith(
                      color: activeIconIndex == 2
                          ? IOColors.brand600
                          : IOColors.brand300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => action(3),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: activeIconIndex == 3
                          ? IOColors.brand600.withAlpha(30)
                          : Colors.transparent,
                    ),
                    child: Icon(
                      Icons.credit_score,
                      size: 35,
                      color: IOColors.brand600,
                    ),
                  ),
                  Text(
                    'Зээл төлөлт',
                    style: IOStyles.caption2Regular.copyWith(
                      color: activeIconIndex == 3
                          ? IOColors.brand600
                          : IOColors.brand300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
