import 'package:g_json/g_json.dart';

class LoanExtensionModel {
  final double allIntBal;
  final double billFineBal;
  final double princBal;
  LoanExtensionModel.fromJson(JSON json)
    : allIntBal = json['allIntBal'].ddoubleValue,
      billFineBal = json['billFineBal'].ddoubleValue,
      princBal = json['princBal'].ddoubleValue;
}
