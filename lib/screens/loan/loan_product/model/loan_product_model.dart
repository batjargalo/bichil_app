import 'package:g_json/g_json.dart';

class LoanLimitModel {
  final double loanLimit;
  final double scoreLimit;
  final int loanCount;
  final String prodCode;
  final String message;
  final bool contract;

  LoanLimitModel.fromJson(JSON json)
    : loanLimit = json['loan_limit'].ddoubleValue,
      scoreLimit = json['score_limit'].ddoubleValue,
      loanCount = json['loan_count'].integerValue,
      prodCode = json['prod_code'].stringValue,
      message = json['message'].stringValue,
      contract = json['contract'].booleanValue;
}
