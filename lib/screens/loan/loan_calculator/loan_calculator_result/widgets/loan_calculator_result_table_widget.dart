import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class LoanCalculatorResultTableWidget extends StatelessWidget {
  final LoanCalculatorModel model;
  const LoanCalculatorResultTableWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final items = model.items;
    return IOCardBorderWidget(
      child: TableView.builder(
        cellBuilder: _buildCell,
        columnCount: 7,
        columnBuilder: (index) {
          return TableSpan(
            extent: index == 0 || index == 6
                ? const FixedTableSpanExtent(16)
                : const FixedTableSpanExtent(80),
          );
        },
        rowCount: items.length + 2,
        rowBuilder: (index) {
          return TableSpan(
            extent: index == 0 || index == items.length + 1
                ? const FixedTableSpanExtent(44)
                : const FixedTableSpanExtent(24),
            backgroundDecoration: index == 0 || index == items.length + 1
                ? SpanDecoration(
                    border: SpanBorder(
                      leading: index == items.length + 1
                          ? const BorderSide(
                              width: 1,
                              color: IOColors.strokePrimary,
                            )
                          : BorderSide.none,
                      trailing: index == 0
                          ? const BorderSide(
                              width: 1,
                              color: IOColors.strokePrimary,
                            )
                          : BorderSide.none,
                    ),
                  )
                : null,
          );
        },
        diagonalDragBehavior: DiagonalDragBehavior.free,
        pinnedRowCount: 1,
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    final items = model.items;
    if (vicinity.row == 0) {
      return TableViewCell(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            switch (vicinity.column) {
              1 => 'Огноо',
              2 => 'Үндсэн',
              3 => 'Хүү',
              4 => 'Нийт төлөлт',
              5 => 'Үлдэгдэл',
              _ => '',
            },
            style: IOStyles.caption2Bold.copyWith(
              color: IOColors.brand500,
            ),
          ),
        ),
      );
    } else if (vicinity.row == items.length + 1) {
      final base = items.map((e) => e.base).fold(0.0, (p, e) => p + e);

      final rate = items.map((e) => e.rate).fold(0.0, (p, e) => p + e);

      final total = base + rate;

      return TableViewCell(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            switch (vicinity.column) {
              1 => 'Нийт',
              2 => base.toCurrency(),
              3 => rate.toCurrency(),
              4 => total.toCurrency(),
              5 => '',
              _ => '',
            },
            style: IOStyles.caption2Bold,
          ),
        ),
      );
    } else {
      final item = items[vicinity.row - 1];
      return TableViewCell(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            switch (vicinity.column) {
              1 => item.date,
              2 => item.base.toCurrency(),
              3 => item.rate.toCurrency(),
              4 => item.total.toCurrency(),
              5 => item.balance.toCurrency(),
              _ => '',
            },
            style: IOStyles.caption2Regular,
          ),
        ),
      );
    }
  }
}
