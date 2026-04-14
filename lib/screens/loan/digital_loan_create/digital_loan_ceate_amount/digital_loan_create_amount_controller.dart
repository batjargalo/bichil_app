import 'dart:math';

import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DigitalLoanCreateAmountController extends IOController {
  // final LoanLimitModel item;
  final refresher = RefreshController();
  // final loanLimitLoading = false.obs;

  final amount = 0.0.obs;
  final term = 0.obs;
  final mountlyPayment = 0.0.obs;
  final totalPayment = 0.0.obs;
  final button = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.small,
    isEnabled: false,
  ).obs;
  final calculateScore = IOButtonModel(
    label: 'Эрх шинэчлэх',
    type: IOButtonType.secondary,
    size: IOButtonSize.small,
    isEnabled: true,
  ).obs;
  final selectedTerm = 0.obs;
  final loanLimit = <LoanLimitModel>{}.obs;
  var loanLimitText = ''.obs;

  //
  final chargeAmount = 0.0.obs;

  void setSelectedTerm(int index) {
    final durations = getDurationList();
    if (index >= 0 && index < durations.length) {
      selectedTerm.value = durations[index]['value'];
    }
  }

  static const List<dynamic> underMonth = [7, 14, 21, 30, 3, 6, 9, 12];
  static const List<Map<String, dynamic>> duration1 = [
    {'label': '7 хоног', 'value': 0},
    {'label': '14 хоног', 'value': 1},
    {'label': '21 хоног', 'value': 2},
    {'label': '1 сар', 'value': 3},
  ];

  static const List<Map<String, dynamic>> duration2 = [
    {'label': '7 хоног', 'value': 0},
    {'label': '14 хоног', 'value': 1},
    {'label': '21 хоног', 'value': 2},
    {'label': '1 сар', 'value': 3},
    {'label': '3 сар', 'value': 4},
  ];
  static const List<Map<String, dynamic>> duration3 = [
    {'label': '7 хоног', 'value': 0},
    {'label': '14 хоног', 'value': 1},
    {'label': '21 хоног', 'value': 2},
    {'label': '1 сар', 'value': 3},
    {'label': '3 сар', 'value': 4},
    {'label': '6 сар', 'value': 5},
  ];
  static const List<Map<String, dynamic>> duration4 = [
    {'label': '7 хоног', 'value': 0},
    {'label': '14 хоног', 'value': 1},
    {'label': '21 хоног', 'value': 2},
    {'label': '1 сар', 'value': 3},
    {'label': '3 сар', 'value': 4},
    {'label': '6 сар', 'value': 5},
    {'label': '9 сар', 'value': 6},
  ];
  static const List<Map<String, dynamic>> duration5 = [
    {'label': '7 хоног', 'value': 0},
    {'label': '14 хоног', 'value': 1},
    {'label': '21 хоног', 'value': 2},
    {'label': '1 сар', 'value': 3},
    {'label': '3 сар', 'value': 4},
    {'label': '6 сар', 'value': 5},
    {'label': '9 сар', 'value': 6},
    {'label': '1 жил', 'value': 7},
  ];
  List<Map<String, dynamic>> getDurationList() {
    switch (amount.value) {
      case <= 300000:
        return duration1;
      case <= 1000000:
        return duration2;
      case <= 2500000:
        return duration3;
      case <= 4000000:
        return duration4;
      default:
        return duration5;
    }
  }

  //

  DigitalLoanCreateAmountController(
    // {required this.item}
  );

  @override
  void onInit() {
    super.onInit();
    getLoanLimit(true);
    ever(amount, (value) {
      button.update((val) {
        val?.isEnabled = value >= 50000.0;
      });
    });
    everAll([amount, selectedTerm], (_) {
      if (selectedTerm.value <= 3) {
        final P = amount.value;
        final r = ((loanLimit.first.loanInt * 0.01) / 365) * underMonth[selectedTerm.value];
        final n = 1;
        mountlyPayment.value = P * r * (pow(1 + r, n) as double) / ((pow(1 + r, n) as double) - 1);
        totalPayment.value = mountlyPayment.value * n;
      } else {
        final P = amount.value;
        late double B = P;
        late double interestSum = 0.0;
        final r = ((loanLimit.first.loanInt * 0.01) / 365) * 30;
        final n = underMonth[selectedTerm.value];
        mountlyPayment.value = P * (r * (pow(1 + r, n) as double) / ((pow(1 + r, n) as double) - 1));

        for (int i = 0; i < n; i++) {
          final daysInMonth = DateTime(DateTime.now().year, DateTime.now().month + i + 1, 0).day;
          final interest = B * ((loanLimit.first.loanInt * 0.01) / 365 * daysInMonth);
          interestSum += interest;
          final principal = mountlyPayment.value - interest;
          B = B - principal;
        }

        totalPayment.value = interestSum + amount.value;
      }
    });
  }

  void onTapNext() async {
    if (loanLimit.first.loanCount > 0) {
      showError(text: 'Одоогоор танд нэг зээл идэвхтэй байна. Зээлээ төлж дууссаны дараа дахин зээл авах боломжтой.');
      return;
    } else {
      final userRelated = await UserApi().getUserRelated();
      if (userRelated.isSuccess) {
        final relatedData = userRelated.data;
        if (relatedData.listValue.length < 3) {
          toWarningUserInfo(
            titleText: 'Анхаарна уу.',
            text: "Та өөрийн ойр дотны 3 хүний мэдээллийг оруулна уу.",
            buttonText: 'Бүртгэлээ шинэчлэх',
          );
          return;
        }
      } else {
        showError(text: userRelated.message);
        return;
      }
      if (amount.value > loanLimit.first.scoreLimit) {
        showError(text: '${loanLimit.first.scoreLimit}-с ихгүй утга оруулна уу');
        return;
      } else if (amount.value < 50000) {
        showError(text: '50000₮-с багагүй утга оруулна уу');
        return;
      }
      // LoanRoute.toDigitalLoanContract();

      final pin = await AppRoute.toPin();
      if (pin == null) return;

      isLoading.value = true;
      button.update((val) {
        val?.isLoading = true;
      });
      final response = await LoanApi().checkPin(pin: pin);

      final model = DigitalLoanCreateModel(amount: amount.value, term: term.value, pinCode: pin, payDay: 0);
      // final response = await LoanApi().createDigitalLoan(model: model);

      isLoading.value = false;
      button.update((val) {
        val?.isLoading = false;
      });

      if (response.isSuccess) {
        await AppRoute.toSuccess(title: 'Амжилттай', description: response.message, buttonText: 'Үргэлжлүүлэх');
        LoanRoute.toDigitalLoanContract(item: model);
        // Get.until((route) => route.isFirst);
        // if (Get.isRegistered<LoanTabController>()) {
        //   Get.find<LoanTabController>().onRefresh();
        // }
      } else if (response.message == "Та гүйлгээний нууц үгээ тохируулна уу") {
        toWarning(titleText: 'Анхаарна уу.', text: response.message, buttonText: 'Нууц үг үүсгэх');
      } else {
        showError(text: response.message);
      }
    }
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
