import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';

class SavingCreateModel {
  late String name;
  late SavingCreateFrequencyModel term;
  double firstAmount = 0;
  late bool hasSubscribe;
  late SavingCreateFrequencyModel frequency;
  late BankModel bank;
  late String account;
  late String accountName;

  double totalYield = 0;
  double periodYield = 0;
  double rate = 0;

  double get totalAmount => firstAmount + totalYield;

  Map<String, dynamic> toMap() => {
        'account_name': name,
        'balance': firstAmount,
        'term_len': term.value,
        'return_frequency': frequency.value,
        'is_monthly': hasSubscribe,
        'monthly_deposit_day': 0,
        'monthly_deposit_amount': 0,
      };
}
