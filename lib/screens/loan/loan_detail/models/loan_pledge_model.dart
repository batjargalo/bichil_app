import 'package:g_json/g_json.dart';

class LoanPledgeModel {
  final String name;
  final String registerNo;
  final String date;
  final String description;
  final String penalty;
  final String tax;

  LoanPledgeModel({
    required this.name,
    required this.registerNo,
    required this.date,
    required this.description,
    this.penalty = '',
    this.tax = '',
  });

  factory LoanPledgeModel.fromJson(JSON json) {
    return LoanPledgeModel(
      name: json['name'].stringValue,
      registerNo: json['register_no'].stringValue,
      date: json['date'].stringValue,
      description: json['description'].stringValue,
      penalty: json['penalty'].stringValue,
      tax: json['tax'].stringValue,
    );
  }
}
