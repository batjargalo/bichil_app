import 'package:g_json/g_json.dart';

class BankModel {
  final int id;
  final String name;
  final String image;

  BankModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        image = json['image'].stringValue;
}
