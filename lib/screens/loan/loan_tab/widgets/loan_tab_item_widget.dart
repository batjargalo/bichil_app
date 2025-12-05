import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoanTabItemWidget extends StatelessWidget {
  final bool isSecure;
  final LoanInfoModel item;
  const LoanTabItemWidget({
    super.key,
    required this.isSecure,
    required this.item,
  });

  void onTapDetail() {
    LoanRoute.toDetail(loan: item);
  }

  void onTapPay() {
    LoanRoute.toPayInfo(loan: item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: IOColors.backgroundQuarternary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (item.canTakeLoan) ...[
            LoanTabScoringWidget(
              isSecure: isSecure,
              model: item,
            )
          ],
          IOCardBorderWidget(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item.prodName,
                        style: IOStyles.body2Semibold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SvgPicture.asset(
                      'assets/icons/chevron.right.svg',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _RowWidget(
                  isSecure: isSecure,
                  title: 'Зээлийн үлдэгдэл',
                  value: item.princBal.toCurrency(),
                ),
                const SizedBox(height: 16),
                _RowWidget(
                  isSecure: isSecure,
                  title: 'Дараагийн төлөлт',
                  value: item.nextSchdDate.isEmpty
                      ? '-'
                      : item.nextSchdDate
                          .toFormattedString(format: 'yyyy/MM/dd'),
                  valueStyle: IOStyles.caption1SemiBold.copyWith(
                    color: item.isOver
                        ? IOColors.errorPrimary
                        : IOColors.textPrimary,
                  ),
                ),
                if (item.isOver) ...[
                  const SizedBox(height: 16),
                  _RowWidget(
                    isSecure: isSecure,
                    title: 'Хэтэрсэн өдөр',
                    value: '${item.overdueDayCount} өдөр',
                    valueStyle: IOStyles.caption1SemiBold.copyWith(
                      color: IOColors.errorPrimary,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                _RowWidget(
                  isSecure: isSecure,
                  title: 'Төлөх дүн',
                  value: item.nextSchdTotal.toCurrency(),
                  valueStyle: IOStyles.caption1SemiBold.copyWith(
                    color: item.isOver
                        ? IOColors.errorPrimary
                        : IOColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: IOButtonWidget(
                        onPressed: onTapDetail,
                        model: IOButtonModel(
                          label: 'Дэлгэрэнгүй',
                          type: IOButtonType.secondary,
                          size: IOButtonSize.small,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: IOButtonWidget(
                        onPressed: onTapPay,
                        model: IOButtonModel(
                          label: 'Зээл төлөх',
                          type: IOButtonType.primary,
                          size: IOButtonSize.small,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RowWidget extends StatelessWidget {
  final bool isSecure;
  final String title;
  final String value;
  final TextStyle? valueStyle;
  const _RowWidget({
    required this.isSecure,
    required this.title,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: IOStyles.caption1Regular.copyWith(
            color: IOColors.textTertiary,
          ),
        ),
        Text(
          isSecure ? '**********' : value,
          style: valueStyle ?? IOStyles.caption1SemiBold,
        ),
      ],
    );
  }
}
