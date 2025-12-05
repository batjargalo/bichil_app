import 'package:g_json/g_json.dart';

class FaqModel {
  final int id;
  final String question;
  final String answer;
  final String qaType;

  FaqModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        question = json['question'].stringValue,
        answer = json['answer'].stringValue,
        qaType = json['qa_type'].stringValue;
}
