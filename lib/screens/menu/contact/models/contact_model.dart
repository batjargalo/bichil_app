import 'package:g_json/g_json.dart';

class ContactModel {
  final String phone;
  final String email;
  final String address;
  final String facebook;
  final String instagram;
  final String twitter;
  final String youtube;
  final String web;

  ContactModel.fromJson(JSON json)
      : phone = json['phone'].stringValue,
        email = json['email'].stringValue,
        address = json['address'].stringValue,
        facebook = json['facebook'].stringValue,
        instagram = json['instagram'].stringValue,
        twitter = json['twitter'].stringValue,
        youtube = json['youtube'].stringValue,
        web = json['web'].stringValue;
}
