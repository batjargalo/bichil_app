import 'package:bichil/library/library.dart';
import 'package:g_json/g_json.dart';

class SavingDetailModel {
  final int id;
  final String accountNumber;
  final String accountName;
  final double balance;
  final double availBal;
  final double blockBal;
  final String closeDate;
  final String returnFrequency;
  final String createdDate;
  final bool isMonthly;
  final String monthlyDepositDay;
  final double monthlyDepositAmount;
  final double interestRate;
  final String startDate;
  final String currency;
  final int user;
  final String bankAccount;
  final String contract;
  final String terms;
  final double acrintBal;
  final double expectedIntBal;

  String get duration {
    final dateRange = DateRange.dateDifference(
      fromDate: startDate.toDate,
      toDate: closeDate.toDate,
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

  SavingDetailModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        accountNumber = json['account_number'].stringValue,
        accountName = json['account_name'].stringValue,
        balance = json['balance'].ddoubleValue,
        availBal = json['avail_bal'].ddoubleValue,
        blockBal = json['block_bal'].ddoubleValue,
        closeDate = json['close_date'].stringValue,
        returnFrequency = json['return_frequency'].stringValue,
        createdDate = json['created_date'].stringValue,
        isMonthly = json['is_monthly'].booleanValue,
        monthlyDepositDay = json['monthly_deposit_day'].stringValue,
        monthlyDepositAmount = json['monthly_deposit_amount'].ddoubleValue,
        interestRate = json['interest_rate'].ddoubleValue,
        startDate = json['start_date'].stringValue,
        currency = json['currency'].stringValue,
        user = json['user'].integerValue,
        bankAccount = json['bank_account'].stringValue,
        contract = json['contract'].stringValue,
        terms = json['terms'].stringValue,
        acrintBal = json['acrintBal'].ddoubleValue,
        expectedIntBal = json['expectedIntBal'].ddoubleValue;

  SavingDetailModel.fromHistoryJson(JSON json)
      : id = json['id'].integerValue,
        accountNumber = json['acntCode'].stringValue,
        accountName = json['prodName'].stringValue,
        balance = json['currentBal'].ddoubleValue,
        availBal = json['avail_bal'].ddoubleValue,
        blockBal = json['block_bal'].ddoubleValue,
        closeDate = json['close_date'].stringValue,
        returnFrequency = json['return_frequency'].stringValue,
        createdDate = json['maturityDate'].stringValue,
        isMonthly = json['is_monthly'].booleanValue,
        monthlyDepositDay = json['monthly_deposit_day'].stringValue,
        monthlyDepositAmount = json['monthly_deposit_amount'].ddoubleValue,
        interestRate = json['intRate'].ddoubleValue,
        startDate = json['startDate'].stringValue,
        currency = json['currency'].stringValue,
        user = json['user'].integerValue,
        bankAccount = json['bank_account'].stringValue,
        contract = json['contract'].stringValue,
        terms = json['terms'].stringValue,
        acrintBal = json['acrintBal'].ddoubleValue,
        expectedIntBal = json['expectedIntBal'].ddoubleValue;
}
