import 'package:g_json/g_json.dart';

class LoanLimitModel {
  final int? loanLimit;
  final bool? limitCalcButton;
  final bool? getLoanButton;

  LoanLimitModel.fromJson(JSON json)
    : loanLimit = json['loan_limit'].integerValue,
      limitCalcButton = json['limit_calc_button'].booleanValue,
      getLoanButton = json['get_loan_button'].booleanValue;
}
