import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class LoanProductController extends IOController {
  final refresher = RefreshController();
  final products = <LoanProductModel>[].obs;
  final loanLimit = <LoanLimitModel>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts(true);
    getLoanLimit(true);
  }

  Future onRefresh() async {
    if (HelperManager.isLogged) {
      await getProducts(false);
      await getLoanLimit(false);
      refresher.refreshCompleted();
    }
  }

  void onTapLoan() {
    LoanRoute.toProductList();
  }

  void onCreateLoan() {
    if (loanLimit.first.loanLimit > 0) {
      if (loanLimit.first.loanCount <= 5) {
        LoanRoute.toCreateAmount(item: loanLimit.first);
      } else {
        showWarning(text: "Таны зээлийн тоо олгох хязгаарт хүрсэн байна.");
      }
    } else {
      showWarning(text: "Зээлийн боломжит эрх байхгүй байна. Та зээлийн эрхээ шинэчилнэ үү.");
    }
  }

  Future getLoanLimit(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await LoanApi().getLoanLimits();
    if (isInitial) isInitialLoading.value = false;
    refresher.refreshCompleted();
    if (response.isSuccess) {
      loanLimit.assignAll({LoanLimitModel.fromJson(response.data)});
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future getProducts(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await InfoApi().getSubProducts(id: 4);
    if (isInitial) isInitialLoading.value = false;
    refresher.refreshCompleted();

    if (response.isSuccess) {
      products.value = response.data.listValue.map((e) => LoanProductModel.fromJson(e)).toList();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }
}
