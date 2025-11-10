import 'package:g_json/g_json.dart';

class LoanProductModel {
  final int id;
  final String name;
  final double maxAmount;
  final String interest;
  final String duration;
  final String advancePayment;
  final String collateralType;
  final String productCode;
  final String createdDate;

  LoanProductModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        maxAmount = json['max_amount'].ddoubleValue,
        interest = json['interest'].stringValue,
        duration = json['duration'].stringValue,
        advancePayment = json['advance_payment'].stringValue,
        collateralType = json['collateral_type'].stringValue,
        productCode = json['product_code'].stringValue,
        createdDate = json['created_date'].stringValue;
}
