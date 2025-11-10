import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class LoanCalculatorFormTypeWiget extends StatelessWidget {
  final List<LoanCalculatorRepaymentType> items;
  final LoanCalculatorRepaymentType selected;
  final ValueChanged<LoanCalculatorRepaymentType> onChanged;

  const LoanCalculatorFormTypeWiget({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Эргэн төлөлтийн нөхцөл',
              style: IOStyles.body2Semibold,
            ),
          ),
          const Divider(height: 1, thickness: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final item = items[index];
              return IORadio(
                label: item.title,
                value: item,
                groupValue: selected,
                onTap: onChanged,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemCount: items.length,
          ),
        ],
      ),
    );
  }
}
