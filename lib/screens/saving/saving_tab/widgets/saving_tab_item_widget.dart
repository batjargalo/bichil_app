import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SavingTabItemWidget extends StatefulWidget {
  final bool isSecure;
  final SavingDetailModel item;

  const SavingTabItemWidget({
    super.key,
    required this.isSecure,
    required this.item,
  });

  @override
  State<SavingTabItemWidget> createState() => _SavingTabItemWidgetState();
}

class _SavingTabItemWidgetState extends State<SavingTabItemWidget> {
  final addAmount = IOButtonModel(
    label: 'Итгэлцэл нэмэх',
    type: IOButtonType.primary,
    size: IOButtonSize.small,
  );
  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.item.accountName,
                      style: IOStyles.body2Semibold.copyWith(
                        color: IOColors.textSecondary,
                      ),
                    ),
                    Text(
                      widget.isSecure
                          ? '**********'
                          : widget.item.balance.toCurrency(),
                      style: IOStyles.h6,
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/icons/chevron.right.svg',
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _RowWidget(
            isSecure: widget.isSecure,
            title: 'Хуримтлагдсан өгөөж',
            value: '+${widget.item.acrintBal.toCurrency()}',
            valueStyle: IOStyles.caption1SemiBold.copyWith(
              color: IOColors.brand500,
            ),
          ),
          const SizedBox(height: 12),
          _RowWidget(
            isSecure: widget.isSecure,
            title: 'Хугацааны эцэст өгөх өгөөж',
            value: '+${widget.item.expectedIntBal.toCurrency()}',
            valueStyle: IOStyles.caption1SemiBold.copyWith(
              color: IOColors.brand500,
            ),
          ),
          const SizedBox(height: 12),
          _RowWidget(
            isSecure: widget.isSecure,
            title: 'Дуусах хугацаа',
            value: widget.item.closeDate.toFormattedString(
              format: 'yyyy/MM/dd',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: IOButtonWidget(
                  model: IOButtonModel(
                    label: 'Дэлгэрэнгүй',
                    type: IOButtonType.secondary,
                    size: IOButtonSize.small,
                  ),
                  onPressed: onTapDetail,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: IOButtonWidget(
                  model: addAmount,
                  onPressed: onTapAdd,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onTapDetail() {
    SavingRoute.toDetail(saving: widget.item);
  }

  // void onTapStatement() {
  //   SavingRoute.toStatement(code: widget.item.accountNumber);
  // }

  void onTapAdd() async {
    setState(() {
      addAmount.isLoading = true;
    });
    final response = await SavingApi().getSavingCondition();
    setState(() {
      addAmount.isLoading = false;
    });

    if (response.isSuccess) {
      final isAvailable = response.data['is_deposit_available'].booleanValue;
      final amount = response.data['minimum_amount_deposit'].ddoubleValue;

      if (isAvailable) {
        SavingRoute.toAddBalance(
          code: widget.item.accountNumber,
          minimumAmount: amount,
        );
      } else {
        const IOAlert(
          type: IOAlertType.warning,
          bodyText: 'Түр хугацаанд итгэлцэлд мөнгө нэмэх боломжгүй байна.',
          acceptText: 'Хаах',
        ).show();
      }
    } else {
      IOAlert(
        type: IOAlertType.error,
        bodyText: response.message,
      ).show();
    }
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
            color: IOColors.textSecondary,
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
