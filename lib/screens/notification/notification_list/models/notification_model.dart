import 'package:g_json/g_json.dart';

class NotificationModel {
  final int id;
  final String text;
  final String createdDate;
  final int userId;
  String state;
  final String type;
  final JSON actionData;
  final String action;

  NotificationModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        text = json['text'].stringValue,
        createdDate = json['createdDate'].stringValue,
        userId = json['user_id'].integerValue,
        state = json['state'].stringValue,
        type = json['type'].stringValue,
        actionData = json['action_data'],
        action = json['action'].stringValue;
}
