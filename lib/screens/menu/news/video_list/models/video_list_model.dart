import 'package:g_json/g_json.dart';

class VideoListModel {
  final int id;
  final String title;
  final String image;
  final String videoUrl;
  final String createdDate;

  String get imageUrl => image;

  VideoListModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        title = json['title'].stringValue,
        image = json['image'].stringValue,
        videoUrl = json['video_url'].stringValue,
        createdDate = json['created_date'].stringValue;
}
