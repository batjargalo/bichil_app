import 'package:bichil/screens/screens.dart';

class LoanCalculatorModel {
  late int amount;
  late int month;
  late LoanCalculatorRepaymentType type;
  late double rate;

  List<LoanCalculatorResultModel> items = [];

  LoanCalculatorModel({
    required this.amount,
    required this.month,
    required this.type,
    required this.rate,
  });

  Map<String, dynamic> toMap() => {
        'loan_amount': amount,
        'total_months': month,
        'type': type.name,
        'interest_rate': rate,
      };
}
