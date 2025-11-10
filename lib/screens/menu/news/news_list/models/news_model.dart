import 'package:g_json/g_json.dart';

class NewsModel {
  final int id;
  final String title;
  final String image;
  final String content;
  final String publishedDate;
  final String feedType;

  String get imageUrl => image;

  NewsModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        title = json['title'].stringValue,
        image = json['image'].stringValue,
        content = json['content'].stringValue,
        publishedDate = json['published_date'].stringValue,
        feedType = json['feed_type'].stringValue;
}
