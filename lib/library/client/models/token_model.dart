import 'package:g_json/g_json.dart';

class TokenModel {
  String access;
  String refresh;

  TokenModel.fromJson(JSON json)
      : access = json['access'].stringValue,
        refresh = json['refresh'].stringValue;

  Map<String, dynamic> toMap() {
    return {
      'access': access,
      'refresh': refresh,
    };
  }
}
