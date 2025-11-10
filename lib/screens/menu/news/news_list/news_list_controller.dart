import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsListController extends IOController {
  final news = <NewsModel>[].obs;
  final refresher = RefreshController();
  final pagination = PaginationModel();

  @override
  void onInit() {
    super.onInit();
    getData(true);
  }

  Future onRefresh() async {
    pagination.reset();
    await getData(false);
  }

  Future onLoad() async {
    if (pagination.shouldFetch) {
      await getData(false);
      return;
    }
    refresher.loadComplete();
    refresher.refreshCompleted();
  }

  Future getData(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await InfoApi().getNews(
      offset: pagination.offset,
      limit: pagination.limit,
    );
    if (isInitial) isInitialLoading.value = false;
    refresher.loadComplete();
    refresher.refreshCompleted();

    if (response.isSuccess) {
      news.value =
          response.data.listValue.map((e) => NewsModel.fromJson(e)).toList();
    }
  }

  void onTap(NewsModel item) {
    MenuRoute.toNewsDetail(news: item);
  }
}
