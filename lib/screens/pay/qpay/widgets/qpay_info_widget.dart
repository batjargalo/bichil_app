import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class QpayInfoWidget extends StatelessWidget {
  final List<QpayInfoModel> info;
  const QpayInfoWidget({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = info[index];
          return RowWidget(
            title: item.title,
            value: item.value,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: info.length,
      ),
    );
  }
}
