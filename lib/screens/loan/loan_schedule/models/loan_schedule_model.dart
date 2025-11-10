import 'package:g_json/g_json.dart';

class LoanScheduleModel {
  final String schdDate;
  final double amount;
  final double intAmount;
  final double totalAmount;
  final double theorBal;
  final int nrsVersion;
  final bool isPaid;

  LoanScheduleModel.fromJson(JSON json)
      : schdDate = json['schdDate'].stringValue,
        amount = json['amount'].ddoubleValue,
        intAmount = json['intAmount'].ddoubleValue,
        totalAmount = json['totalAmount'].ddoubleValue,
        theorBal = json['theorBal'].ddoubleValue,
        nrsVersion = json['nrsVersion'].integerValue,
        isPaid = json['isPaid'].booleanValue;
}
