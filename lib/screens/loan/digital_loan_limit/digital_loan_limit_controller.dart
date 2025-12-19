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
  final limit = <LoanLimitModel>{}.obs;
  final loanLimit = <LoanLimitModel>{}.obs;

  final chargeAmount = 0.0.obs;
  final limitChargeLoading = false.obs;

  final takeLoan = IOButtonModel(
    label: 'Зээл авах',
    type: IOButtonType.primary,
    size: IOButtonSize.small,
  ).obs;

  final signContract = IOButtonModel(
    label: 'Гэрээ байгуулах',
    type: IOButtonType.primary,
    size: IOButtonSize.small,
  ).obs;

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
          ? 'Та зээлийн эрхээ тогтоолгох уу?'
          : 'Та зээлийн эрх шинэчлэхдээ итгэлтэй байна уу ?',
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
      onResult(
        data: response.data,
        amount: amount,
        payType: LoanLimitType.create,
      );
    } else if (response.message ==
        "Та өөрийн ашигладаг мэйл хаягаа бүртгүүлнэ үү") {
      toWarningEmail(
        titleText: 'Анхаарна уу?',
        text: response.message,
        buttonText: 'Мэйл хаяг бүртгүүлэх',
      );
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
      loanLimit.assignAll({LoanLimitModel.fromJson(response.data)});
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future onResult({
    required JSON data,
    required double amount,
    required LoanLimitType payType,
  }) async {
    final fee = data['fee'].ddoubleValue;
    final invoice = data['local_invoice_number'].stringValue;
    final urls = data['urls'].listValue
        .map((e) => QpayModel.fromJson(e))
        .toList();
    final typeText = switch (payType) {
      LoanLimitType.create => 'Эрх тогтоох',
      LoanLimitType.change => 'эрх шинэчлэх',
    };
    final successText = switch (payType) {
      LoanLimitType.create =>
        'Таны зээлийн эрх тогтоолгох төлбөр амжилттай хийгдлээ. Бид таны зээлийн эрхийг тогтоохын тул ДАН системээс таны мэдээллийг авахыг анхаарна уу.',
      LoanLimitType.change =>
        'Таны зээлийн эрх шинэчлэх төлбөр амжилттай хийгдлээ. Бид таны зээлийн эрхийг тогтоохын тул ДАН системээс таны мэдээллийг авахыг анхаарна уу',
    };
    final info = [
      QpayInfoModel(title: 'Төрөл', value: typeText),
      QpayInfoModel(title: 'Төлөх мөнгөн дүн', value: amount.toCurrency()),
      QpayInfoModel(title: 'Шимтгэл', value: fee.toCurrency()),
      QpayInfoModel(
        title: 'Нийт төлөх дүн',
        value: (fee + amount).toCurrency(),
      ),
    ];
    final qpay = QpayScreenModel(
      title: 'Зээлийн эрх',
      invoice: invoice,
      info: info,
      urls: urls,
    );
    final result = await AppRoute.toQpay(model: qpay);
    if (result == null) return;
    await AppRoute.toSuccess(
      title: 'Амжилттай',
      description: successText,
      buttonText: "Үргэлжлүүлэх",
    );
    customerInfoDan();
  }

  Future customerInfoDan() async {
    final result = await LoanRoute.toCustomerInfoDan();
    if (result == null) return;

    // if (result.exist('form')) {
    //   final fields = result['form']
    //       .listValue
    //       .map((e) => SignUpInfoModel.fromJson(e))
    //       .toList();
    //   model.fields = fields;
    //   AuthRoute.toSignUpInfo(model);
    // } else {
    //   AuthRoute.toSignUpPassword(model);
    // }
  }

  void onCreateLoan() {
    if (loanLimit.first.loanLimit > 0) {
      if (loanLimit.first.loanCount <= 5) {
        LoanRoute.toCreateAmount(item: loanLimit.first);
      } else {
        showWarning(text: "Таны зээлийн тоо олгох хязгаарт хүрсэн байна.");
      }
    } else {
      showWarning(
        text:
            "Зээлийн боломжит эрх байхгүй байна. Та зээлийн эрхээ шинэчилнэ үү.",
      );
    }
  }

  void onSignContract() {
    Get.back();
    LoanRoute.toDigitalLoanContract();
  }

  // void onBack() {
  //   Get.back();
  //   if (Get.isRegistered<LoanTabController>()) {
  //     Get.find<LoanTabController>().onRefresh();
  //   }
  // }
}
