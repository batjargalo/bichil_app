import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SavingHistoryDetailWidget extends StatelessWidget {
  final SavingDetailModel model;
  const SavingHistoryDetailWidget({super.key, required this.model});

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
              model.accountName,
              style: IOStyles.body1SemiBold,
            ),
          ),
          const Divider(thickness: 1, height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _RowWidget(
                  title: 'Хугацаа',
                  value: model.duration,
                ),
                const SizedBox(height: 16),
                _RowWidget(
                  title: 'Нээсэн огноо',
                  value: model.startDate.toFormattedString(
                    format: 'yyyy/MM/dd',
                  ),
                ),
                const SizedBox(height: 16),
                _RowWidget(
                  title: 'Дуусах огноо',
                  value: model.closeDate.toFormattedString(
                    format: 'yyyy/MM/dd',
                  ),
                ),
                const SizedBox(height: 16),
                _RowWidget(
                  title: 'Хүү (жилээр)',
                  value: '${model.interestRate}%',
                ),
              ],
            ),
          ),
          if (model.isMonthly) ...[
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 16),
            _RowWidget(
              title: 'Тогтмол хуримтлуулах дүн',
              value: model.monthlyDepositAmount.toCurrency(),
            ),
            const SizedBox(height: 16),
            _RowWidget(
              title: 'Хуримтлуулах давтамж',
              value: model.monthlyDepositDay,
            ),
            const SizedBox(height: 16),
          ],
          // const Divider(height: 1, thickness: 1),
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: _RowWidget(
          //     title: 'Нийт авах өгөөж',
          //     value: model.expectedIntBal.toCurrency(),
          //   ),
          // ),
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
