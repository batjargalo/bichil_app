import 'package:g_json/g_json.dart';

class LoanInfoModel {
  final String acntCode;
  final String prodName;
  final String prodType;
  final double princBal;
  final double advAmount;
  final double approvAmount;
  final double availComBal;
  final double baseFixedIntRate;
  final int termLen;
  final String startDate;
  final String endDate;
  final int paymentCount;
  final int paidCount;
  final String nextSchdDate;
  final double nextSchdTotal;
  final int overdueDayCount;
  final String purpose;
  final String status;
  final String statusName;
  final String acntManagerName;
  final bool isExpired;
  final LoanInfoTerm termBasis;

  //Production deer oorchlogdono
  LoanInfoType get type => switch (purpose) {
        'PURP00000033' => LoanInfoType.car,
        'PURP00000028' => LoanInfoType.car,
        'PURP00000079' => LoanInfoType.saving,
        _ => LoanInfoType.other,
      };

  int get paidCountPercent {
    return advAmount == 0 ? 0 : paidAmount * 100 ~/ advAmount;
  }

  double get paidCountProgress {
    return advAmount == 0 ? 0 : paidAmount / advAmount;
  }

  double get paidAmount => advAmount - princBal;

  bool get isOver => overdueDayCount > 0;

  bool get canTakeLoan => prodType == 'LINE';

  LoanInfoModel.fromJson(JSON json)
      : acntCode = json['acntCode'].stringValue,
        prodName = json['prodName'].stringValue,
        prodType = json['prodType'].stringValue,
        princBal = json['princBal'].ddoubleValue,
        advAmount = json['advAmount'].ddoubleValue,
        approvAmount = json['approvAmount'].ddoubleValue,
        availComBal = json['availComBal'].ddoubleValue,
        baseFixedIntRate = json['baseFixedIntRate'].ddoubleValue,
        termLen = json['termLen'].integerValue,
        startDate = json['startDate'].stringValue,
        endDate = json['endDate'].stringValue,
        paymentCount = json['paymentCount'].integerValue,
        paidCount = json['paidCount'].integerValue,
        nextSchdDate = json['nextSchdDate'].stringValue,
        nextSchdTotal = json['nextSchdTotal'].ddoubleValue,
        overdueDayCount = json['overdueDayCount'].integerValue,
        purpose = json['purpose'].stringValue,
        status = json['status'].stringValue,
        statusName = json['statusName'].stringValue,
        acntManagerName = json['acntManagerName'].stringValue,
        isExpired = json['isExpired'].booleanValue,
        termBasis = switch (json['termBasis'].stringValue) {
          'D' => LoanInfoTerm.day,
          'M' => LoanInfoTerm.month,
          'Y' => LoanInfoTerm.year,
          _ => LoanInfoTerm.none,
        };
}

enum LoanInfoType { car, saving, other }

enum LoanInfoTerm {
  none(title: ''),
  day(title: 'өдөр'),
  month(title: 'сар'),
  year(title: 'жил');

  const LoanInfoTerm({required this.title});

  final String title;
}
