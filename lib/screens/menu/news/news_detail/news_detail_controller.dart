import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class NewsDetailController extends IOController {
  final NewsModel news;
  final info = NewsModel.fromJson(JSON.nil).obs;

  NewsDetailController({required this.news});

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future getData() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getNewsInfo(id: news.id);
    isInitialLoading.value = false;

    if (response.isSuccess) {
      info.value = NewsModel.fromJson(response.data);
    } else {
      showError(text: response.message);
    }
  }
}
