import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class LoanScheduleScreen extends GetView<LoanScheduleController> {
  const LoanScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IOCardBorderWidget(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Table(
                          defaultColumnWidth: const IntrinsicColumnWidth(),
                          children: getRow(),
                        ),
                      ),
                    ),
                    // child: TableView.builder(
                    //   cellBuilder: buildCell,
                    //   columnCount: 7,
                    //   columnBuilder: (index) {
                    //     return TableSpan(
                    //       extent: index == 0 || index == 6
                    //           ? const FixedTableSpanExtent(16)
                    //           : const FixedTableSpanExtent(70),
                    //     );
                    //   },
                    //   rowCount: controller.items.length + 2,
                    //   rowBuilder: (index) {
                    //     return TableSpan(
                    //       extent:
                    //           index == 0 || index == controller.items.length + 1
                    //               ? const FixedTableSpanExtent(44)
                    //               : const FixedTableSpanExtent(24),
                    //       backgroundDecoration: index == 0 ||
                    //               index == controller.items.length + 1
                    //           ? SpanDecoration(
                    //               border: SpanBorder(
                    //                 leading:
                    //                     index == controller.items.length + 1
                    //                         ? const BorderSide(
                    //                             width: 1,
                    //                             color: IOColors.strokePrimary,
                    //                           )
                    //                         : BorderSide.none,
                    //                 trailing: index == 0
                    //                     ? const BorderSide(
                    //                         width: 1,
                    //                         color: IOColors.strokePrimary,
                    //                       )
                    //                     : BorderSide.none,
                    //               ),
                    //             )
                    //           : null,
                    //     );
                    //   },
                    //   diagonalDragBehavior: DiagonalDragBehavior.free,
                    //   pinnedRowCount: 1,
                    // ),
                  ),
                ),
              ),
      ),
    );
  }

  List<TableRow> getRow() {
    final headerStyle = IOStyles.caption1Bold.copyWith(
      color: IOColors.brand500,
    );
    const footerStyle = IOStyles.caption1Bold;
    final rows = [
      TableRow(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: IOColors.strokePrimary,
            ),
          ),
        ),
        children: [
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text('Огноо', style: headerStyle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text('Үндсэн', style: headerStyle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text('Хүү', style: headerStyle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text('Нийт төлөлт', style: headerStyle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text('Үлдэгдэл', style: headerStyle),
          ),
          const SizedBox(width: 8),
        ],
      )
    ];

    for (var item in controller.items) {
      const style = IOStyles.caption1Regular;
      final row = TableRow(
        children: [
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.schdDate.toFormattedString(
                format: 'yyyy/MM/dd',
              ),
              style: style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.amount.toCurrency(),
              style: style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.intAmount.toCurrency(),
              style: style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.totalAmount.toCurrency(),
              style: style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.theorBal.toCurrency(),
              style: style,
            ),
          ),
          const SizedBox(width: 8),
        ],
      );
      rows.add(row);
    }

    final base =
        controller.items.map((e) => e.amount).fold(0.0, (p, e) => p + e);

    final rate =
        controller.items.map((e) => e.intAmount).fold(0.0, (p, e) => p + e);

    final total = base + rate;

    final footer = TableRow(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: IOColors.strokePrimary,
          ),
        ),
      ),
      children: [
        const SizedBox(width: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text('Нийт', style: footerStyle),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(base.toCurrency(), style: footerStyle),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(rate.toCurrency(), style: footerStyle),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(total.toCurrency(), style: footerStyle),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text('', style: footerStyle),
        ),
        const SizedBox(width: 8),
      ],
    );

    rows.add(footer);

    return rows;
  }

  TableViewCell buildCell(BuildContext context, TableVicinity vicinity) {
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
    } else if (vicinity.row == controller.items.length + 1) {
      final base =
          controller.items.map((e) => e.amount).fold(0.0, (p, e) => p + e);

      final rate =
          controller.items.map((e) => e.intAmount).fold(0.0, (p, e) => p + e);

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
      final item = controller.items[vicinity.row - 1];
      return TableViewCell(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            switch (vicinity.column) {
              1 => item.schdDate.toFormattedString(
                  format: 'yyyy/MM/dd',
                ),
              2 => item.amount.toCurrency(),
              3 => item.intAmount.toCurrency(),
              4 => item.totalAmount.toCurrency(),
              5 => item.theorBal.toCurrency(),
              _ => '',
            },
            style: IOStyles.caption2Regular.copyWith(
              color: item.isPaid ? IOColors.brand500 : IOColors.textPrimary,
            ),
          ),
        ),
      );
    }
  }
}
