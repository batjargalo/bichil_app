import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';

class AdviceListController extends NewsListController {
  @override
  Future getData(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await InfoApi().getAdvice(
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
}
