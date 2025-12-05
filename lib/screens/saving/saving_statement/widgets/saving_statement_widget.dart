import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class SavingStatementWidget extends StatelessWidget {
  final List<SavingStatementModel> items;
  const SavingStatementWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: IOCardBorderWidget(
        child: TableView.builder(
          cellBuilder: _buildCell,
          columnCount: 6,
          columnBuilder: (index) {
            return TableSpan(
              extent: switch (index) {
                0 => const FixedTableSpanExtent(16),
                5 => const FixedTableSpanExtent(16),
                3 => const FixedTableSpanExtent(140),
                _ => const FixedTableSpanExtent(80),
              },
            );
          },
          rowCount: items.length + 1,
          rowBuilder: (index) {
            return TableSpan(
              extent: index == 0
                  ? const FixedTableSpanExtent(44)
                  : const FixedTableSpanExtent(24),
              backgroundDecoration: index == 0
                  ? const SpanDecoration(
                      border: SpanBorder(
                        trailing: BorderSide(
                          width: 1,
                          color: IOColors.strokePrimary,
                        ),
                      ),
                    )
                  : null,
            );
          },
          diagonalDragBehavior: DiagonalDragBehavior.free,
          pinnedRowCount: 1,
        ),
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    if (vicinity.row == 0) {
      return TableViewCell(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            switch (vicinity.column) {
              1 => 'Огноо',
              2 => 'Гүйлгээ',
              3 => 'Гүйлгээний утга',
              4 => 'Үлдэгдэл',
              _ => '',
            },
            style: IOStyles.caption2Bold.copyWith(
              color: IOColors.brand500,
            ),
          ),
        ),
      );
    } else {
      final item = items[vicinity.row - 1];
      final color =
          vicinity.column == 2 ? item.type.color : IOColors.textPrimary;
      final amountText = switch (item.type) {
        SavingStatemenType.income => '+${item.income.toCurrency()}',
        SavingStatemenType.outcome => '-${item.outcome.toCurrency()}',
        SavingStatemenType.none => '-',
      };

      return TableViewCell(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            switch (vicinity.column) {
              1 => item.txnDate.toFormattedString(
                  format: 'yyyy/MM/dd',
                ),
              2 => amountText,
              3 => item.txnDesc,
              4 => item.balance.toCurrency(),
              _ => '',
            },
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: IOStyles.caption2Regular.copyWith(
              color: color,
            ),
          ),
        ),
      );
    }
  }
}
