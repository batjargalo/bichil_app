import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
import 'package:g_json/g_json.dart';

class LoanProductController extends IOController {
  final titleText = 'Дижитал зээлийн эрх';
  final refresher = RefreshController();
  final productsReq = <LoanProductModel>[].obs;
  final limit = <LoanLimitModel>{}.obs;
  final loanLimit = <LoanLimitModel>{}.obs;
  var loanLimitText = ''.obs;
  final chargeAmount = 0.0.obs;
  final limitChargeLoading = false.obs;
  final savingData = <SavingDetailModel>[].obs;
  final loans = <LoanInfoModel>[].obs;
  // final loan = Rx<LoanInfoModel?>(null);
  final productsLine = <LoanProductModel>[].obs;

  final takeLoan = IOButtonModel(label: 'Зээл авах', type: IOButtonType.primary, size: IOButtonSize.small).obs;

  final signContract = IOButtonModel(
    label: 'Гэрээ байгуулах',
    type: IOButtonType.primary,
    size: IOButtonSize.small,
  ).obs;

  @override
  void onInit() {
    isInitialLoading.value = true;
    super.onInit();
    getProductsReq(true);
    getLoanLimit(true);
    getChargeAmount();
    getSaving(true);
    getLineLoanList(true);
    getProductsLine(true);
    // isInitialLoading.value = false;
  }

  void onTapSavingLoan() {
    final result = SessionManager.shared.checkBankAccount();
    if (result == false) return;
    LoanRoute.toCreateSavingAmount(saving: savingData);
  }

  Future getSaving(bool isInitial) async {
    final response = await SavingApi().getSavingList();
    if (response.isSuccess) {
      savingData.value = response.data.listValue.map((e) => SavingDetailModel.fromJson(e)).toList();
    }
  }

  Future onRefresh() async {
    isInitialLoading.value = true;

    if (HelperManager.isLogged) {
      await getProductsReq(false);
      await getLoanLimit(false);
      await getSaving(false);
      await getLineLoanList(false);
      await getProductsLine(false);
      isInitialLoading.value = false;
      refresher.refreshCompleted();
    }
  }

  void onTapProduct(String collType) {
    final result = SessionManager.shared.checkBankAccount();
    if (result == false) return;

    switch (collType) {
      case 'property':
        LoanRoute.toCreateProperty();
        break;
      case 'car':
        LoanRoute.toCreateCar();
        break;
      case 'phone_number':
        LoanRoute.toCreatePhone();
        break;
      default:
        break;
    }
  }

  void toRecreateAmount(String productCode) {
    LoanRoute.toRecreateAmount(item: findLineLoan(productCode)!);
  }

  LoanInfoModel? findLineLoan(String productCode) {
    final chosenLine = loans.firstWhereOrNull((e) => e.prodCode == productCode);
    return chosenLine;
  }

  Future getLineLoanList(bool isInitial) async {
    final response = await LoanApi().getLineLoanList();

    if (response.isSuccess) {
      loans.value = response.data.listValue.map((e) => LoanInfoModel.fromJson(e)).toList();
      // loan.value = loans.firstWhereOrNull((e) => e.canTakeLoan);
    }
  }

  void onCreateLoan() {
    if (loanLimit.first.scoreLimit > 0) {
      if (loanLimit.first.loanCount < 1) {
        LoanRoute.toCreateAmount();
      } else {
        showWarning(text: "Таны зээлийн тоо олгох хязгаарт хүрсэн байна.");
      }
    } else {
      onPay(LoanLimitType.create, PayType.values.first);
      // showWarning(text: "Зээлийн боломжит эрх байхгүй байна. Та зээлийн эрхээ шинэчилнэ үү.");
    }
  }

  void onSignContract() {
    Get.back();
    // LoanRoute.toDigitalLoanContract();
  }

  void onScoreCal() {
    Get.back();
    LoanRoute.toDigitaLoanLimit();
  }

  Future getLoanLimit(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await LoanApi().getLoanLimits();
    if (isInitial) isInitialLoading.value = false;
    refresher.refreshCompleted();
    if (response.isSuccess) {
      loanLimit.assignAll({LoanLimitModel.fromJson(response.data)});
      loanLimitText = response.message.obs;
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future getProductsReq(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await InfoApi().getSubProducts(id: 4);
    if (isInitial) isInitialLoading.value = false;
    refresher.refreshCompleted();

    if (response.isSuccess) {
      productsReq.value = response.data.listValue.map((e) => LoanProductModel.fromJson(e)).toList();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future getProductsLine(bool isInitial) async {
    if (isInitial) isInitialLoading.value = true;
    final response = await InfoApi().getSubProducts(id: 5);
    if (isInitial) isInitialLoading.value = false;
    refresher.refreshCompleted();

    if (response.isSuccess) {
      productsLine.value = response.data.listValue.map((e) => LoanProductModel.fromJson(e)).toList();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  // Future onRefresh() async {
  //   if (HelperManager.isLogged) {
  //     await getLoanLimit(false);
  //     refresher.refreshCompleted();
  //   }
  // }

  // void onTapLoan() {
  //   LoanRoute.toProductList();
  // }

  void onPay(LoanLimitType loanLimitType, PayType payType) {
    if (loanLimit.first.loanCount > 1) {
      showError(text: 'Одоогоор танд нэг зээл идэвхтэй байна. Зээлээ төлж дууссаны дараа дахин зээл авах боломжтой.');
      return;
    }
    if (SessionManager.shared.checkBankAccount()) {
      Get.focusScope?.unfocus();
      onPayCharge(loanLimitType);
    }
  }

  Future onPayCharge(LoanLimitType loanLimitType) async {
    final result = await showWarning(
      text: loanLimitType == LoanLimitType.create
          ? 'Таны зээлийн эрхийн хэмжээг зээл авах тухай бүрт шинэчлэн тогтоохыг анхаарна уу.'
          : 'Та зээлийн эрх шинэчлэхдээ итгэлтэй байна уу ?',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    customerInfoDan();
  }

  Future getChargeAmount() async {
    chargeAmount.value = 2700;
  }

  Future onResult({required JSON data, required double amount, required LoanLimitType payType}) async {
    final fee = data['fee'].ddoubleValue;
    final invoice = data['local_invoice_number'].stringValue;
    final urls = data['urls'].listValue.map((e) => QpayModel.fromJson(e)).toList();
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
      // QpayInfoModel(title: 'Төлөх мөнгөн дүн', value: amount.toCurrency()),
      // QpayInfoModel(title: 'Qpay хураамж', value: fee.toCurrency()),
      QpayInfoModel(title: 'Нийт төлөх дүн', value: (fee + amount).toCurrency()),
    ];
    final qpay = QpayScreenModel(title: 'Зээлийн эрх', invoice: invoice, info: info, urls: urls);
    final result = await AppRoute.toQpay(model: qpay);
    if (result == null) return;
    await AppRoute.toSuccess(title: 'Амжилттай', description: successText, buttonText: "Үргэлжлүүлэх");
    customerInfoDan();
  }

  Future customerInfoDan() async {
    final result = await LoanRoute.toCustomerInfoDan();
    if (result == null) return;
  }
}
 // final amount = chargeAmount.value;

    // isLoading.value = true;
    // limitChargeLoading.value = true;

    // final response = await LoanApi().payLimitCharge(amount: amount);

    // isLoading.value = false;
    // limitChargeLoading.value = false;

    // if (response.isSuccess) {
    //   onResult(
    //     data: response.data,
    //     amount: amount,
    //     payType: LoanLimitType.create,
    //   );
    // } else if (response.message ==
    //     "Та өөрийн ашигладаг мэйл хаягаа бүртгүүлнэ үү") {
    //   toWarningEmail(
    //     titleText: 'Анхаарна уу.',
    //     text: response.message,
    //     buttonText: 'Мэйл хаяг бүртгүүлэх',
    //   );
    // } else {
    //   showError(text: response.message);
    // }