import 'package:g_json/g_json.dart';

class QpayDanModel {
  final String name;
  final String description;
  final String logo;
  final String link;

  QpayDanModel.fromJson(JSON json)
    : name = json['name'].stringValue,
      description = json['description'].stringValue,
      logo = json['logo'].stringValue,
      link = json['link'].stringValue;
}
