import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoanHistoryListController extends IOController {
  final titleText = 'Зээлийн түүх';
  final items = <LoanInfoModel>[].obs;
  final pagination = PaginationModel();
  final refresher = RefreshController();

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
    final response = await LoanApi().getHistory(
      offset: pagination.offset,
      limit: pagination.limit,
    );
    if (isInitial) isInitialLoading.value = false;
    refresher.loadComplete();
    refresher.refreshCompleted();

    if (response.isSuccess) {
      final temp = response.data.listValue
          .map((e) => LoanInfoModel.fromJson(e))
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

  void onTapItem(LoanInfoModel item) {
    LoanRoute.toHistoryDetail(code: item.acntCode);
  }
}
