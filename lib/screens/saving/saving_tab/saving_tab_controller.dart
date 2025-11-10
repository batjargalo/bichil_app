import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SavingTabController extends IOController {
  final tab = Get.find<TabBarController>();
  final refresher = RefreshController();
  final items = <SavingDetailModel>[].obs;
  final add = IOButtonModel(
    label: 'Шинэ итгэлцэл үүсгэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    suffixIcon: 'add.svg',
  );

  final isSecure = HelperManager.isSecureSaving.obs;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future onRefresh() async {
    if (isLogged) {
      getData();
      refresher.refreshCompleted();
    }
  }

  Future getData() async {
    final response = await SavingApi().getSavingList();

    if (response.isSuccess) {
      items.value = response.data.listValue
          .map(
            (e) => SavingDetailModel.fromJson(e),
          )
          .toList();
    }
  }

  Future onTapEye() async {
    await UserStoreManager.shared.write(kSecureSaving, !isSecure.value);
    isSecure.value = HelperManager.isSecureSaving;
  }

  void onTapAdd() {
    SavingRoute.toCreateCondition();
  }
}
