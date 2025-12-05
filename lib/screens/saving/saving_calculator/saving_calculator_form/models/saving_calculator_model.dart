import 'package:bichil/screens/screens.dart';

class SavingCalculatorModel {
  late double amount;
  late SavingCalculatorPeriodType period;
  late SavingCalculatorFrequencyType frequency;

  double totalAmount = 0;
  double periodAmount = 0;

  SavingCalculatorModel({
    required this.amount,
    required this.period,
    required this.frequency,
  });

  Map<String, dynamic> toMap() => {
        'total_amount': amount,
        'total_months': period.value,
        'yield_frequency': frequency.value,
      };
}
