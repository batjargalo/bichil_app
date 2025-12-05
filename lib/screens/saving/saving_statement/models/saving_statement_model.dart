import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';

class SavingStatementModel {
  final String postDate;
  final double income;
  final double outcome;
  final String txnDesc;
  final double balance;
  final int contCurRate;
  final String acntCode;
  final String userBrchCode;
  final String txnNo;
  final String txnCode;
  final String balTypeCode;
  final String jrno;
  final String curCode;
  final String contAcntCode;
  final int curRate;
  final String jritemNo;
  final String txnDate;
  final String contAcntName;
  final double available;
  final double begbalance;
  final double endbalance;

  SavingStatemenType get type {
    if (income > 0) return SavingStatemenType.income;
    if (outcome > 0) return SavingStatemenType.outcome;
    return SavingStatemenType.none;
  }

  SavingStatementModel.fromJson(JSON json)
      : postDate = json['postDate'].stringValue,
        income = json['income'].ddoubleValue,
        outcome = json['outcome'].ddoubleValue,
        txnDesc = json['txnDesc'].stringValue,
        balance = json['balance'].ddoubleValue,
        contCurRate = json['contCurRate'].integerValue,
        acntCode = json['acntCode'].stringValue,
        userBrchCode = json['userBrchCode'].stringValue,
        txnNo = json['txnNo'].stringValue,
        txnCode = json['txnCode'].stringValue,
        balTypeCode = json['balTypeCode'].stringValue,
        jrno = json['jrno'].stringValue,
        curCode = json['curCode'].stringValue,
        contAcntCode = json['contAcntCode'].stringValue,
        curRate = json['curRate'].integerValue,
        jritemNo = json['jritemNo'].stringValue,
        txnDate = json['txnDate'].stringValue,
        contAcntName = json['contAcntName'].stringValue,
        available = json['available'].ddoubleValue,
        begbalance = json['begbalance'].ddoubleValue,
        endbalance = json['endbalance'].ddoubleValue;
}

enum SavingStatemenType {
  income(color: IOColors.successPrimary, symbol: '+'),
  outcome(color: IOColors.errorPrimary, symbol: '-'),
  none(color: IOColors.textPrimary, symbol: '');

  const SavingStatemenType({
    required this.color,
    required this.symbol,
  });

  final Color color;
  final String symbol;
}
