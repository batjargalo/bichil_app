import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class VideoListController extends IOController {
  final items = <VideoListModel>[].obs;
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
    final response = await InfoApi().getVideos(
      offset: pagination.offset,
      limit: pagination.limit,
    );
    if (isInitial) isInitialLoading.value = false;
    refresher.loadComplete();
    refresher.refreshCompleted();

    if (response.isSuccess) {
      items.value = response.data.listValue
          .map((e) => VideoListModel.fromJson(e))
          .toList();
    }
  }

  void onTap(VideoListModel item) {
    MenuRoute.toVideoDetail(video: item);
  }
}
