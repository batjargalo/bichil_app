import 'package:g_json/g_json.dart';

class SavingCreateConditionModel {
  final int id;
  final String contractNumber;
  final String contractName;
  final double interestRate;
  final String interestRateText;
  final double cancelInterestRate;
  final double minimumAmountBalance;
  final double minimumAmountDeposit;
  final String minimumPeriodText;
  final int minimumPeriodMonths;
  final int maximumPeriodMonths;
  final bool isDepositAvailable;
  final List<SavingCreateFrequencyModel> periodOptions;
  final List<SavingCreateFrequencyModel> frequencyOptions;

  SavingCreateConditionModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        contractNumber = json['contract_number'].stringValue,
        contractName = json['contract_name'].stringValue,
        interestRate = json['interest_rate'].ddoubleValue,
        interestRateText = json['interest_rate_text'].stringValue,
        cancelInterestRate = json['cancel_interest_rate'].ddoubleValue,
        minimumAmountBalance = json['minimum_amount_balance'].ddoubleValue,
        minimumAmountDeposit = json['minimum_amount_deposit'].ddoubleValue,
        minimumPeriodText = json['minimum_period_text'].stringValue,
        minimumPeriodMonths = json['minimum_period_months'].integerValue,
        maximumPeriodMonths = json['maximum_period_months'].integerValue,
        isDepositAvailable = json['is_deposit_available'].booleanValue,
        periodOptions = json['period_options']
            .listValue
            .map((e) => SavingCreateFrequencyModel.fromJson(e))
            .toList(),
        frequencyOptions = json['frequency_options']
            .listValue
            .map((e) => SavingCreateFrequencyModel.fromJson(e))
            .toList();
}

class SavingCreateFrequencyModel {
  final String name;
  final String value;

  SavingCreateFrequencyModel.fromJson(JSON json)
      : name = json['name'].stringValue,
        value = json['value'].stringValue;
}

class SavingCalculatorScheduleModel {
  final String number;
  final String date;
  final double amount;

  SavingCalculatorScheduleModel.fromJson(JSON json)
      : number = json['Yield Number'].stringValue,
        date = json['Due Date'].stringValue,
        amount = json['Yield Amount'].ddoubleValue;
}
