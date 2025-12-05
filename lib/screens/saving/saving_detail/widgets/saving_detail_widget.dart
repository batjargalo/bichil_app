import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SavingDetailWidget extends StatelessWidget {
  final SavingDetailModel detail;
  const SavingDetailWidget({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Text(
              'Итгэлцлийн нэр',
              style: IOStyles.caption1Regular,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Text(
              detail.accountName,
              style: IOStyles.body1SemiBold,
            ),
          ),
          const Divider(thickness: 1, height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _RowWidget(
                  title: 'Үлдэгдэл',
                  value: detail.balance.toCurrency(),
                ),
                const SizedBox(height: 16),
                _RowWidget(
                  title: 'Хугацаа',
                  value: detail.duration,
                ),
                const SizedBox(height: 16),
                _RowWidget(
                  title: 'Нээсэн огноо',
                  value: detail.startDate.toFormattedString(
                    format: 'yyyy/MM/dd',
                  ),
                ),
                const SizedBox(height: 16),
                _RowWidget(
                  title: 'Дуусах огноо',
                  value: detail.closeDate.toFormattedString(
                    format: 'yyyy/MM/dd',
                  ),
                ),
                const SizedBox(height: 16),
                _RowWidget(
                  title: 'Хүү (жилээр)',
                  value: '${detail.interestRate}%',
                ),
                // if (detail.returnFrequency.isNotEmpty) ...[
                //   const SizedBox(height: 16),
                //   _RowWidget(
                //     title: 'Өгөөж авах давтамж',
                //     value: detail.returnFrequency,
                //   ),
                // ],
              ],
            ),
          ),
          if (detail.blockBal > 0) ...[
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: RowWidget(
                title: 'Битүүмжлэгдсэн дүн',
                value: detail.blockBal.toCurrency(),
                valueStyle: IOStyles.caption1Bold.copyWith(
                  color: IOColors.warningPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (detail.isMonthly) ...[
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 16),
            _RowWidget(
              title: 'Тогтмол хуримтлуулах дүн',
              value: detail.monthlyDepositAmount.toCurrency(),
            ),
            const SizedBox(height: 16),
            _RowWidget(
              title: 'Хуримтлуулах давтамж',
              value: detail.monthlyDepositDay,
            ),
            const SizedBox(height: 16),
          ],
          const Divider(height: 1, thickness: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _RowWidget(
              title: 'Нийт авах өгөөж',
              value: detail.expectedIntBal.toCurrency(),
            ),
          ),
        ],
      ),
    );
  }
}

class _RowWidget extends StatelessWidget {
  final String title;
  final String value;

  const _RowWidget({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: IOStyles.caption1Regular,
        ),
        Text(
          value,
          style: IOStyles.caption1Bold,
        ),
      ],
    );
  }
}
