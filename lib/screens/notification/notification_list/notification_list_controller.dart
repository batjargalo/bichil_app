import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class NotificationListController extends IOController {
  final NotificationType type;
  final pagination = PaginationModel();
  final refresher = RefreshController();
  final items = <NotificationModel>[].obs;
  NotificationListController({required this.type});
  @override
  void onInit() {
    super.onInit();
    getData(true);
  }

  Future onRefresh() async {
    pagination.reset();
    getData(false);
  }

  Future onLoad() async {
    if (pagination.shouldFetch) {
      await getData(false);
    } else {
      refresher.loadComplete();
      refresher.refreshCompleted();
    }
  }

  Future getData(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await UserApi().getNotifications(
      offset: pagination.offset,
      limit: pagination.limit,
      type: type.name,
    );
    if (isInitial) isInitialLoading.value = false;
    refresher.loadComplete();
    refresher.refreshCompleted();

    if (response.isSuccess) {
      final temp = response.data.listValue
          .map((e) => NotificationModel.fromJson(e))
          .toList();
      if (pagination.isInitial) {
        items.value = temp;
      } else {
        items.value += temp;
      }

      if (temp.length < pagination.limit) {
        pagination.setValue(
          itemCount: items.length,
          count: items.length,
        );
      } else {
        pagination.setValue(
          itemCount: items.length,
          count: items.length + 1,
        );
      }
    } else {
      showError(text: response.message);
    }
  }

  void onTapItem(NotificationModel item) async {
    final response = await UserApi().readNotification(
      id: item.id,
    );

    if (response.isSuccess) {
      item.state = 'read';
      refresh();
      Get.find<TabBarController>().getNotificationCount();
    }
  }
}

enum NotificationType { private, news }
