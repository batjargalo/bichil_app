import 'package:bichil/library/library.dart';
import 'package:g_json/g_json.dart';

class SavingInfoModel {
  final String acntCode;
  final double currentBal;
  final double acrintBal;
  final double intRate;
  final String maturityDate;
  final int tenor;
  final String startDate;
  final String prodName;
  final String curCode;
  final String status;
  final double expectedIntBal;

  String get duration {
    final dateRange = DateRange.dateDifference(
      fromDate: startDate.toDate,
      toDate: maturityDate.toDate,
    );
    var text = '';
    if (dateRange.years > 0) {
      text += '${dateRange.years} жил';
    }
    if (dateRange.months > 0) {
      text += text.isNotEmpty ? ' ' : '';
      text += '${dateRange.months} сар';
    }
    if (dateRange.days > 0) {
      text += text.isNotEmpty ? ' ' : '';
      text += '${dateRange.days} хоног';
    }

    return text;
  }

  SavingInfoModel.fromJson(JSON json)
      : acntCode = json['acntCode'].stringValue,
        currentBal = json['currentBal'].ddoubleValue,
        acrintBal = json['acrintBal'].ddoubleValue,
        intRate = json['intRate'].ddoubleValue,
        maturityDate = json['maturityDate'].stringValue,
        tenor = json['tenor'].integerValue,
        startDate = json['startDate'].stringValue,
        prodName = json['prodName'].stringValue,
        curCode = json['curCode'].stringValue,
        status = json['status'].stringValue,
        expectedIntBal = json['expectedIntBal'].ddoubleValue;
}
