import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class LoanTabItemWidget extends StatelessWidget {
  final LoanInfoModel item;

  const LoanTabItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => LoanRoute.toDetail(loan: item),
      child: Container(
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
                Expanded(
                  child: Text(
                    item.prodName,
                    style: IOStyles.caption1Regular.copyWith(
                      color: IOColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                _StatusBadge(isOver: item.isOver),
              ],
            ),

            const SizedBox(height: 8),

            Text(item.princBal.toCurrency(), style: IOStyles.body1Bold),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Төлөлт хийх огноо',
                      style: IOStyles.caption2Regular.copyWith(
                        color: IOColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.nextSchdDate.toFormattedString(format: 'yyyy.MM.dd'),
                      style: IOStyles.caption1SemiBold,
                    ),
                  ],
                ),

                _RemainingDaysCircle(
                  days: item.overdueDayCount == 0
                      ? DateTime.tryParse(item.nextSchdDate)
                                ?.add(Duration(days: 1))
                                .difference(DateTime.now())
                                .inDays ??
                            0
                      : item.overdueDayCount,
                  isOver:
                      DateTime.now().isBefore(
                        DateTime.tryParse(item.nextSchdDate) ?? DateTime.now(),
                      )
                      ? false
                      : true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

class _RemainingDaysCircle extends StatelessWidget {
  final int days;
  final bool isOver;

  const _RemainingDaysCircle({required this.days, required this.isOver});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isOver ? IOColors.errorPrimary : IOColors.successPrimary,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '$days',
        style: IOStyles.body1SemiBold.copyWith(
          color: isOver ? IOColors.errorPrimary : IOColors.successPrimary,
        ),
      ),
    );
  }
}
