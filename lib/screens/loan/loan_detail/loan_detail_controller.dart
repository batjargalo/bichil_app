import 'package:bichil/library/library.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:intl/intl.dart';

class LoanDetailController extends IOController {
  final LoanInfoModel loan;
  final pledgeList = <LoanPledgeModel>[].obs;
  final schedule = <LoanScheduleModel>[].obs;
  List<LoanDetailActionModel> get actions => [
    if (loan.canTakeLoan) LoanDetailActionGetModel(title: 'Зээл авах'),
    // LoanDetailActionCardModel(title: 'Карт холбох'),
    LoanDetailActionRepaymentModel(title: 'Эргэн төлөлтийн хуваарь'),
    LoanDetailActionStatementModel(title: 'Хуулга'),
    // LoanDetailActionCalculateModel(title: 'Тооцоолуур'),
  ];

  List<LoanDetailActionModel> get pledge => [
    LoanDetailActionPledgeModel(title: 'Барьцаа хөрөнгө'),
  ];
  final RxInt selectedIndex = (0).obs;
  double allIntBal = 0.0;
  double billFineBal = 0.0;
  double princBal = 0.0;
  double totalExtensionAmount = 0.0;
  LoanDetailController({required this.loan});
  final customPayment = 0.0.obs;
  final closeAmount = 0.0.obs;
  final schdleAmount = 0.0.obs;

  final textController = TextEditingController();
  final formatter = CurrencyTextInputFormatter.currency(
    symbol: '₮',
    decimalDigits: 0,
  );
  final scheduleLoading = false.obs;
  final customLoading = false.obs;
  final closeLoading = false.obs;
  final extensionLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    textController.text = formatter.formatDouble(0.0);
    getPledge();
    checkLoading();
  }

  Future checkLoading() async {
    isInitialLoading.value = true;
    await Future.wait([
      getExtensionAmount(),
      getScheduleData(),
      getCloseAmount(),
    ]);
    isInitialLoading.value = false;
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool checkIsTodayPayment(String schedule) {
    final today = DateTime.now();
    final itemDate = DateTime.tryParse(schedule);
    if (itemDate != null && isSameDay(itemDate, today)) {
      return true;
    } else {
      return false;
    }
  }

  void onIconTapped(int index) {
    selectedIndex.value = !loan.isOver && index == 2
        ? selectedIndex.value
        : index;
  }

  Future getCloseAmount() async {
    closeLoading.value = true;

    final response = await LoanApi().getLoanCloseAmount(
      code: loan.acntCode,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    closeLoading.value = false;
    if (response.isSuccess) {
      closeAmount.value = response.data['totalBal'].ddoubleValue;
    } else {
      showError(text: response.message);
    }
  }

  Future getPledge() async {
    try {
      isLoading.value = true;
      final response = await LoanApi().getCollateralInfo(
        accountCode: loan.acntCode,
      );
      final payload = response.data.listValue.isNotEmpty
          ? response.data.listValue
          : response.json.listValue;

      pledgeList.clear();
      if (payload.isEmpty) {
        return;
      }

      pledgeList.addAll(
        payload
            .map((item) => LoanPledgeModel.fromJson(item))
            .toList(growable: false),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onTapAction(LoanDetailActionModel action) {
    switch (action) {
      case LoanDetailActionGetModel():
        final result = SessionManager.shared.checkBankAccount();
        if (result == false) return;
        LoanRoute.toRecreateAmount(item: loan);
        break;
      case LoanDetailActionCardModel():
        break;
      case LoanDetailActionRepaymentModel():
        LoanRoute.toSchedule(loan: loan);
        break;
      case LoanDetailActionCalculateModel():
        LoanRoute.toCalculatorForm(loan: loan);
        break;
      case LoanDetailActionStatementModel():
        LoanRoute.toStatement(loan: loan);
        break;
      case LoanDetailActionPledgeModel():
        LoanRoute.toPledgeList(items: pledgeList.toList());
        break;
    }
  }

  Future getExtensionAmount() async {
    try {
      extensionLoading.value = true;
      final response = await LoanApi().getDigitalLoanExtension(
        accountCode: loan.acntCode,
      );

      if (response.isSuccess) {
        allIntBal = response.data['allIntBal'].ddoubleValue;
        billFineBal = response.data['billFineBal'].ddoubleValue;
        princBal = response.data['princBal'].ddoubleValue;
        totalExtensionAmount = allIntBal + billFineBal + princBal;
      } else {
        showError(text: response.message);
      }
    } finally {
      extensionLoading.value = false;
    }
  }

  void getTotalExtensionAmount() {
    totalExtensionAmount = allIntBal + billFineBal + princBal;
  }

  Future getScheduleData() async {
    scheduleLoading.value = true;
    final response = await LoanApi().getLoanSchedule(code: loan.acntCode);
    if (response.isSuccess) {
      schedule.value = response.data.listValue
          .map((e) => LoanScheduleModel.fromJson(e))
          .toList();
      calculateSchedulePayment();
      scheduleLoading.value = false;
    } else {
      scheduleLoading.value = false;

      Get.back();
      showError(text: response.message);
    }
  }

  void onChangePayment(double val) {
    String formatted = formatter.formatDouble(val);

    textController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );

    if (val > loan.totalBal) {
      customPayment.value = loan.totalBal;
      String formatted = formatter.formatDouble(customPayment.value);
      textController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    } else {
      customPayment.value = val;
    }
    update();
  }

  // Өөр дүнгээр төлөх
  Future onCustomsLoan() async {
    final result = await showWarning(
      text: 'Та өөр дүнгээр төлөхдөө итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    final amount = customPayment.value;

    isLoading.value = true;
    customLoading.value = true;

    final response = await LoanApi().payLoan(
      code: loan.acntCode,
      amount: amount,
    );

    isLoading.value = false;
    customLoading.value = false;

    if (response.isSuccess) {
      onResult(
        data: response.data,
        amount: amount,
        payType: LoanPayType.custom,
      );
    } else {
      showError(text: response.message);
    }
  }

  // Зээл хаах
  Future onCloseLoan() async {
    final result = await showWarning(
      text: 'Та зээл хаахдаа итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    final amount = closeAmount.value;

    isLoading.value = true;

    final response = await LoanApi().closeLoan(
      code: loan.acntCode,
      amount: amount,
    );

    isLoading.value = false;

    if (response.isSuccess) {
      onResult(data: response.data, amount: amount, payType: LoanPayType.close);
    } else {
      showError(text: response.message);
    }
  }

  // Зээл сунгах
  Future onExtensionLoan() async {
    final result = await showWarning(
      text: 'Та зээл сунгахдаа итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    final amount = totalExtensionAmount;

    isLoading.value = true;

    final response = await LoanApi().extendLoan(
      code: loan.acntCode,
      amount: amount,
    );

    isLoading.value = false;

    if (response.isSuccess) {
      onResult(
        data: response.data,
        amount: amount,
        payType: LoanPayType.extension,
      );
    } else {
      showError(text: response.message);
    }
  }

  Future<void> calculateSchedulePayment() async {
    schdleAmount.value = schedule.fold<double>(
      0.0,
      (previousValue, element) =>
          previousValue + (element.isPaid ? 0.0 : element.totalAmount),
    );
  }

  // Хуварийн дагуу төлөх
  Future onScheduleLoan(double schdlePay) async {
    // final scheduleItem = schedule.firstWhereOrNull(
    //   (element) => !element.isPaid,
    // );
    if (schdleAmount.value == 0.0) {
      showError(text: 'Төлөх хуваарь байхгүй байна');
      return;
    }
    final amount = schdlePay;

    isLoading.value = true;
    final response = await LoanApi().payLoan(
      code: loan.acntCode,
      amount: amount,
    );
    isLoading.value = false;
    if (response.isSuccess) {
      onResult(
        data: response.data,
        amount: schdlePay,
        payType: LoanPayType.schedule,
      );
    } else {
      showError(text: response.message);
    }
  }

  Future onResult({
    required JSON data,
    required double amount,
    required LoanPayType payType,
  }) async {
    final fee = data['fee'].ddoubleValue;
    final invoice = data['local_invoice_number'].stringValue;
    final urls = data['urls'].listValue
        .map((e) => QpayModel.fromJson(e))
        .toList();
    final typeText = switch (payType) {
      LoanPayType.schedule => 'Хуваарийн дагуу төлөх',
      LoanPayType.custom => 'Өөр дүнгээр төлөх',
      LoanPayType.close || LoanPayType.closeLine => 'Зээл хаах',
      LoanPayType.extension => 'Зээл сунгах',
    };
    final successText = switch (payType) {
      LoanPayType.schedule =>
        'Таны зээлийн эргэн төлөлт ${amount.toCurrency()} амжилттай хийгдлээ',
      LoanPayType.custom =>
        'Таны зээлийн төлөлт ${amount.toCurrency()} амжилттай хийгдлээ',
      LoanPayType.close ||
      LoanPayType.closeLine => 'Таны зээлийн төлөлт амжилттай хийгдэж хаагдлаа',
      LoanPayType.extension =>
        'Таны зээлийн сунгалт ${amount.toCurrency()} амжилттай хийгдлээ',
    };
    final info = [
      QpayInfoModel(title: 'Төрөл', value: typeText),
      QpayInfoModel(title: 'Төлөх мөнгөн дүн', value: amount.toCurrency()),
      QpayInfoModel(title: 'Qpay хураамж', value: fee.toCurrency()),
      QpayInfoModel(
        title: 'Нийт төлөх дүн',
        value: (fee + amount).toCurrency(),
      ),
    ];
    final qpay = QpayScreenModel(
      title: 'Зээл',
      invoice: invoice,
      info: info,
      urls: urls,
    );

    final result = await AppRoute.toQpay(model: qpay);
    if (result == null) return;

    await AppRoute.toSuccess(title: 'Амжилттай', description: successText);
    Get.back();
  }
}
