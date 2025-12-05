import 'package:g_json/g_json.dart';

class LoanCalculatorResultModel {
  final String date;
  final double total;
  final double rate;
  final double base;
  final double balance;

  LoanCalculatorResultModel.fromJson(JSON json)
      : date = json['Due Date'].stringValue,
        total = json['Monthly Payment'].ddoubleValue,
        rate = json['Interest Payment'].ddoubleValue,
        base = json['Principal Payment'].ddoubleValue,
        balance = json['Remaining Balance'].ddoubleValue;
}
