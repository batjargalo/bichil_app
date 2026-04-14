import 'package:g_json/g_json.dart';

class LoanLimitModel {
  final double loanLimit;
  final double scoreLimit;
  final int loanCount;
  final String prodCode;
  final String message;
  final String limitMessage;
  final bool contract;
  final int loanInt;
  final String scoreLimitExpDate;
  LoanLimitModel.fromJson(JSON json)
    : loanLimit = json['loan_limit'].ddoubleValue,
      scoreLimit = json['score_limit'].ddoubleValue,
      loanCount = json['loan_count'].integerValue,
      prodCode = json['prod_code'].stringValue,
      message = json['message'].stringValue,
      limitMessage = json['limit_message'].stringValue,
      contract = json['contract'].booleanValue,
      loanInt = json['loan_interest'].integerValue,
      scoreLimitExpDate = json['score_limit_exp_date'].stringValue;
}
