import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SavingCreateConditionMonthWidget extends StatelessWidget {
  final List<SavingCreateFrequencyModel> months;
  final SavingCreateFrequencyModel selectedMonth;
  final ValueChanged<SavingCreateFrequencyModel> onSelect;

  const SavingCreateConditionMonthWidget({
    super.key,
    required this.months,
    required this.selectedMonth,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: 5,
      children: months.map((e) {
        final isSelected = e == selectedMonth;
        return IOGesture(
          onTap: () => onSelect(e),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? IOColors.brand50 : IOColors.backgroundPrimary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: isSelected ? IOColors.brand500 : IOColors.strokePrimary,
              ),
            ),
            child: Text(
              '${e.value}\nсар',
              textAlign: TextAlign.center,
              style: IOStyles.caption1SemiBold,
            ),
          ),
        );
      }).toList(),
    );
  }
}
