import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';

class BranchCountryModel {
  final String name;
  final int branchCount;
  final int id;
  final List<BranchCityModel> citydistrict;

  BranchCountryModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        branchCount = json['branch_count'].integerValue,
        citydistrict = json['citydistrict']
            .listValue
            .map((e) => BranchCityModel.fromJson(e))
            .where((e) => e.count != 0)
            .toList();
}
