import 'package:g_json/g_json.dart';

class BranchCityModel {
  final String name;
  final int id;
  final int count;

  BranchCityModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        count = json['branch_count'].integerValue;
}
