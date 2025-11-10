class LoanRecreateModel {
  final double amount;
  final String accountNo;
  // final int bankId;
  // final String recipientAccount;
  // final String recipientName;
  final String pinCode;

  final int term;
  final int payDay;

  LoanRecreateModel({
    required this.amount,
    required this.accountNo,
    // required this.bankId,
    // required this.recipientAccount,
    // required this.recipientName,
    required this.pinCode,
    required this.term,
    required this.payDay,
  });

  Map<String, dynamic> toMapFromLoan() => {
        'amount': amount,
        'account_no': accountNo,
        // 'bank_id': bankId,
        // 'recipient_account': recipientAccount,
        // 'recipient_name': recipientName,
        'pin_code': pinCode,
      };

  Map<String, dynamic> toMapFromSaving() => {
        'amount': amount,
        'account_no': accountNo,
        // 'bank_id': bankId,
        // 'recipient_account': recipientAccount,
        // 'recipient_name': recipientName,
        'pin_code': pinCode,
        'pay_day': payDay,
        'term': term,
      };
}
