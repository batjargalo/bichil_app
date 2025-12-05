import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanStatementScreen extends GetView<LoanStatementController> {
  const LoanStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: controller.isInitialLoading.value
                      ? const IOLoading()
                      : controller.items.isEmpty
                          ? const IOEmptyWidget()
                          : IOCardBorderWidget(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Table(
                                    defaultColumnWidth:
                                        const IntrinsicColumnWidth(),
                                    children: getRow(),
                                  ),
                                ),
                              ),
                            ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Эхлэх огноо',
                        style: IOStyles.body2Medium,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Дуусах огноо',
                        style: IOStyles.body2Medium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: IODropdownWidget.custom(
                        model: controller.start,
                        onTap: controller.onTapStart,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: IODropdownWidget.custom(
                        model: controller.end,
                        onTap: controller.onTapEnd,
                      ),
                    ),
                  ],
                ),
              ],
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
      final total = item.totalPrincAmountGrouped + item.totalIntAmountGrouped;
      final row = TableRow(
        children: [
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.txnDate.toFormattedString(
                format: 'yyyy/MM/dd',
              ),
              style: style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.totalPrincAmountGrouped.toCurrency(),
              style: style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.totalIntAmountGrouped.toCurrency(),
              style: style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              total.toCurrency(),
              style: style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.balance.toCurrency(),
              style: style,
            ),
          ),
          const SizedBox(width: 8),
        ],
      );
      rows.add(row);
    }

    final base = controller.items
        .map((e) => e.totalPrincAmountGrouped)
        .fold(0.0, (p, e) => p + e);

    final rate = controller.items
        .map((e) => e.totalIntAmountGrouped)
        .fold(0.0, (p, e) => p + e);

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
}
