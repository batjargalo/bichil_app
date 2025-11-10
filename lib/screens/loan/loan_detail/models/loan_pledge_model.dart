import 'package:g_json/g_json.dart';

class LoanPledgeModel {
  final String mainCurCode;
  final String acntName;
  final int utilId;
  final String useAcntName2;
  final String useAcntName;
  final String useSysName;
  final String linkTypeName;
  final double lastRate;
  final String statusName;
  final String sysName;
  final String linkTypeName2;
  final double useAmount;
  final int useSysNo;
  final int companyCode;
  final int sysNo;
  final String acntCode;
  final double mainAmount;
  final String useAcntCode;
  final double availBal;
  final String useCurCode;
  final DateTime lastRevalDate;
  final bool isBlockInt;
  final double limitAmount;
  final String linkType;
  final String status;

  LoanPledgeModel.fromJson(JSON json)
      : mainCurCode = json['mainCurCode'].stringValue,
        acntName = json['acntName'].stringValue,
        utilId = json['utilId'].integerValue,
        useAcntName2 = json['useAcntName2'].stringValue,
        useAcntName = json['useAcntName'].stringValue,
        useSysName = json['useSysName'].stringValue,
        linkTypeName = json['linkTypeName'].stringValue,
        lastRate = json['lastRate'].ddoubleValue,
        statusName = json['statusName'].stringValue,
        sysName = json['sysName'].stringValue,
        linkTypeName2 = json['linkTypeName2'].stringValue,
        useAmount = json['useAmount'].ddoubleValue,
        useSysNo = json['useSysNo'].integerValue,
        companyCode = json['companyCode'].integerValue,
        sysNo = json['sysNo'].integerValue,
        acntCode = json['acntCode'].stringValue,
        mainAmount = json['mainAmount'].ddoubleValue,
        useAcntCode = json['useAcntCode'].stringValue,
        availBal = json['availBal'].ddoubleValue,
        useCurCode = json['useCurCode'].stringValue,
        lastRevalDate = DateTime.parse(json['lastRevalDate'].stringValue),
        isBlockInt = json['isBlockInt'].booleanValue,
        limitAmount = json['limitAmount'].ddoubleValue,
        linkType = json['linkType'].stringValue,
        status = json['status'].stringValue;
}
