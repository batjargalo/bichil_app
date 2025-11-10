import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SavingCalculatorFormFreqWidget extends StatelessWidget {
  final List<SavingCalculatorFrequencyType> items;
  final SavingCalculatorFrequencyType selected;
  final ValueChanged<SavingCalculatorFrequencyType> onChanged;

  const SavingCalculatorFormFreqWidget({
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
              'Өгөөж авах давтамж',
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
