import 'package:g_json/g_json.dart';

class ForceUpdateServiceTermsModel {
  final bool serviceTerm;

  ForceUpdateServiceTermsModel({required this.serviceTerm});

  ForceUpdateServiceTermsModel.fromJson(JSON json) : serviceTerm = json['service_term'].booleanValue;
}
