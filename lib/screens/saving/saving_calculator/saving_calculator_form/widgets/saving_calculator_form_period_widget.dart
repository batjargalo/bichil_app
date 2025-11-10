import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SavingCalculatorFormPeriodWidget extends StatelessWidget {
  final List<SavingCalculatorPeriodType> items;
  final SavingCalculatorPeriodType selected;
  final ValueChanged<SavingCalculatorPeriodType> onChanged;

  const SavingCalculatorFormPeriodWidget({
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
              'Хугацаа',
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
