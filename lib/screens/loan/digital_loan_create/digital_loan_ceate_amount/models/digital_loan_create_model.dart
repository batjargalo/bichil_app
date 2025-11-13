class DigitalLoanCreateModel {
  final double amount;
  final String pinCode;
  final int term;
  final int payDay;

  DigitalLoanCreateModel({required this.amount, required this.pinCode, required this.term, required this.payDay});

  Map<String, dynamic> toMapFromLoan() => {'amount': amount, 'pay_day': payDay, 'term': term, 'pin_code': pinCode};

  Map<String, dynamic> toMapFromSaving() => {'amount': amount, 'pay_day': payDay, 'term': term, 'pin_code': pinCode};
}
