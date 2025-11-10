import 'package:g_json/g_json.dart';

class DigitalLoanLimitModel {
  final int? loanLimit;
  final bool? limitCalcButton;
  final bool? getLoanButton;

  DigitalLoanLimitModel.fromJson(JSON json)
    : loanLimit = json['loan_limit'].integerValue,
      limitCalcButton = json['limit_calc_button'].booleanValue,
      getLoanButton = json['get_loan_button'].booleanValue;
}
