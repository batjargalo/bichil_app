import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SavingCloseConditionWidget extends StatelessWidget {
  final SavingCloseModel model;
  const SavingCloseConditionWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '${model.type.title} нөхцөл',
              style: IOStyles.body2Semibold,
            ),
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              if (model.type == SavingCloseType.deposite)
                _RowItem(
                  title: 'Итгэлцлийн үлдэгдэл',
                  value: model.balanceToBe.toCurrency(),
                ),
              _RowItem(
                title: 'Бодогдох хүү (жилээр)',
                oldValue: '${model.interestCurrent}%',
                value: '${model.interestToBe}%',
              ),
              _RowItem(
                title: 'Өгөөж',
                oldValue: model.yieldCurrent.toCurrency(),
                value: model.yieldToBe.toCurrency(),
              ),
              const Divider(height: 16, thickness: 1),
              SavingCreateConfirmWidget(
                title: 'Авах мөнгөн дүн',
                value: model.closeAmount.toCurrency(),
                titleStyle: IOStyles.caption1SemiBold,
                valueStyle: IOStyles.caption1Bold.copyWith(
                  color: IOColors.brand500,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final String title;
  final String value;
  final String? oldValue;
  const _RowItem({
    required this.title,
    required this.value,
    this.oldValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: IOStyles.caption1Regular,
            ),
          ),
          const SizedBox(width: 16),
          if (oldValue != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: IOColors.errorSecondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  oldValue!,
                  style: IOStyles.caption2Medium.copyWith(
                    color: IOColors.errorPrimary,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: IOColors.errorPrimary,
                  ),
                ),
              ),
            ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: IOStyles.caption1Bold,
          ),
        ],
      ),
    );
  }
}
