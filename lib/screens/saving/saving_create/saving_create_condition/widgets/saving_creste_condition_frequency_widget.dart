import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SavingCresteConditionFrequencyWidget extends StatelessWidget {
  final List<SavingCreateFrequencyModel> options;
  final SavingCreateFrequencyModel selectedOption;
  final ValueChanged<SavingCreateFrequencyModel> onSelect;
  const SavingCresteConditionFrequencyWidget({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      childAspectRatio: 2.5,
      crossAxisSpacing: 8,
      crossAxisCount: 3,
      children: options.map((e) {
        final isSelected = e.value == selectedOption.value;
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
              e.name,
              textAlign: TextAlign.center,
              style: IOStyles.caption1SemiBold,
            ),
          ),
        );
      }).toList(),
    );
  }
}
