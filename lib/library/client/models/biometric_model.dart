import 'package:g_json/g_json.dart';

class BiometricModel {
  final String username;
  final String phone;
  final String password;

  BiometricModel({
    required this.username,
    required this.phone,
    required this.password,
  });

  BiometricModel.fromJson(JSON json)
      : username = json['username'].stringValue,
        phone = json['phone'].stringValue,
        password = json['password'].stringValue;

  Map<String, dynamic> toMap() => {
        'username': username,
        'phone': phone,
        'password': password,
      };
}
