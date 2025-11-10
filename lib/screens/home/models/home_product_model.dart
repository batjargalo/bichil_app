import 'package:g_json/g_json.dart';

class HomeProductModel {
  final int id;
  final String name;
  final String image;

  final String titleOne;
  final String valueOne;
  final String titleTwo;
  final String valueTwo;
  final String key;

  final bool isBig;
  final String actionType;

  HomeProductModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        image = json['image'].stringValue,
        titleOne = json['title_one'].stringValue,
        valueOne = json['value_one'].stringValue,
        titleTwo = json['title_two'].stringValue,
        valueTwo = json['value_two'].stringValue,
        key = json['key'].stringValue,
        isBig = json['is_big'].booleanValue,
        actionType = json['action_type'].stringValue;
}
