import 'package:g_json/g_json.dart';

class BranchModel {
  final int id;
  final String title;
  final String image;
  final String description;
  final String time;
  final String week;
  final double longitude;
  final double latitude;
  final String contact;

  BranchModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        title = json['title'].stringValue,
        image = json['image'].stringValue,
        description = json['description'].stringValue,
        time = json['time_table'].stringValue,
        week = json['week_table'].stringValue,
        longitude = json['longitude'].ddoubleValue,
        latitude = json['latitude'].ddoubleValue,
        contact = json['contact'].stringValue;
}
