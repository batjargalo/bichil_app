import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum LoanLimitType { create, change }

class DigitalLoanLimitController extends IOController {
  final titleText = 'Дижитал зээлийн эрх';
  final refresher = RefreshController();
  final products = <LoanProductModel>[].obs;
  final loanLimit = <DigitalLoanLimitModel>{}.obs;

  final chargeAmount = 0.0.obs;
  final limitChargeLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLoanLimit(true);
    getChargeAmount();
  }

  Future onRefresh() async {
    if (HelperManager.isLogged) {
      await getLoanLimit(false);
      refresher.refreshCompleted();
    }
  }

  void onTapLoan() {
    LoanRoute.toProductList();
  }

  void onPay(LoanLimitType loanLimitType, PayType payType) {
    Get.focusScope?.unfocus();
    onPayCharge(loanLimitType);
  }

  Future onPayCharge(LoanLimitType loanLimitType) async {
    final result = await showWarning(
      text: loanLimitType == LoanLimitType.create
          ? 'Та зээлийн эрх тогтоолгохдоо итгэлтэй байна уу'
          : 'Та зээлийн эрх шинчлэхдээ итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    final amount = chargeAmount.value;

    isLoading.value = true;
    limitChargeLoading.value = true;

    final response = await LoanApi().payLimitCharge(amount: amount);

    isLoading.value = false;
    limitChargeLoading.value = false;

    if (response.isSuccess) {
      onResult(data: response.data, amount: amount, payType: LoanLimitType.create);
    } else {
      showError(text: response.message);
    }
  }

  Future getChargeAmount() async {
    chargeAmount.value = 1500;
  }

  Future getLoanLimit(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await LoanApi().getLoanLimits();
    if (isInitial) isInitialLoading.value = false;
    refresher.refreshCompleted();

    if (response.isSuccess) {
      loanLimit.assignAll({DigitalLoanLimitModel.fromJson(response.data)});
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future onResult({required JSON data, required double amount, required LoanLimitType payType}) async {
    final fee = data['fee'].ddoubleValue;
    final invoice = data['local_invoice_number'].stringValue;
    final urls = data['urls'].listValue.map((e) => QpayModel.fromJson(e)).toList();
    final typeText = switch (payType) {
      LoanLimitType.create => 'Эрх тогтоох',
      LoanLimitType.change => 'эрх шинчлэх',
    };
    final successText = switch (payType) {
      LoanLimitType.create => 'Таны зээлийн эрх тогтоох төлбөр ${amount.toCurrency()} амжилттай хийгдлээ',
      LoanLimitType.change => 'Таны зээлийн эрх шинчлэх төлбөр ${amount.toCurrency()} амжилттай хийгдлээ',
    };
    final info = [
      QpayInfoModel(title: 'Төрөл', value: typeText),
      QpayInfoModel(title: 'Төлөх мөнгөн дүн', value: amount.toCurrency()),
      QpayInfoModel(title: 'Шимтгэл', value: fee.toCurrency()),
      QpayInfoModel(title: 'Нийт төлөх дүн', value: (fee + amount).toCurrency()),
    ];
    final qpay = QpayScreenModel(title: 'Зэлийн эрх', invoice: invoice, info: info, urls: urls);
    final result = await AppRoute.toQpay(model: qpay);
    if (result == null) return;
    await AppRoute.toSuccess(title: 'Амжилттай', description: successText);
    onBack();
  }

  void onBack() {
    Get.back();
    if (Get.isRegistered<LoanTabController>()) {
      Get.find<LoanTabController>().onRefresh();
    }
  }
}
