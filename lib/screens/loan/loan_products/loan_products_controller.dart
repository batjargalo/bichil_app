import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoanProductsController extends IOController {
  final refresher = RefreshController();
  final products = <LoanProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProducts(true);
  }

  Future onRefresh() async {
    if (HelperManager.isLogged) {
      await getProducts(false);
    }
  }

  Future getProducts(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await InfoApi().getSubProducts(id: 4);
    if (isInitial) isInitialLoading.value = false;
    refresher.refreshCompleted();

    if (response.isSuccess) {
      products.value = response.data.listValue
          .map((e) => LoanProductModel.fromJson(e))
          .toList();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }
}
