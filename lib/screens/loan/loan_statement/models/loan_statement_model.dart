import 'package:g_json/g_json.dart';

class LoanStatementModel {
  final String postDate;
  final String txnDate;
  final double totalPrincAmountGrouped;
  final double totalIntAmountGrouped;
  final double balance;

  LoanStatementModel.fromJson(JSON json)
      : postDate = json['postDate'].stringValue,
        txnDate = json['txnDate'].stringValue,
        totalPrincAmountGrouped = json['totalPrincAmountGrouped'].ddoubleValue,
        totalIntAmountGrouped = json['totalIntAmountGrouped'].ddoubleValue,
        balance = json['balance'].ddoubleValue;
}
