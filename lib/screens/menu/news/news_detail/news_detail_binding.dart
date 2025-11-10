import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class NewsDetailBinding extends Bindings {
  final NewsModel news;
  NewsDetailBinding({required this.news});
  @override
  void dependencies() {
    Get.lazyPut(() => NewsDetailController(news: news));
  }
}
