import 'package:g_json/g_json.dart';

class ForceUpdateModel {
  final String updateType;
  final bool forceUpdate;
  final String message;
  final String suggestedVersion;
  final String url;

  ForceUpdateModel({
    required this.updateType,
    required this.forceUpdate,
    required this.message,
    required this.suggestedVersion,
    required this.url,
  });

  ForceUpdateModel.fromJson(JSON json)
      : updateType = json['update_type'].stringValue,
        forceUpdate = json['force_update'].booleanValue,
        message = json['message'].stringValue,
        suggestedVersion = json['suggested_version'].stringValue,
        url = json['update_url'].stringValue;
}
