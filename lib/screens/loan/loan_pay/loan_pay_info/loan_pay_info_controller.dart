import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class LoanPayInfoController extends IOController {
  final LoanInfoModel loan;
  final titleText = 'Зээл төлөх';

  final customAmount = 0.0.obs;
  final closeAmount = 0.0.obs;
  final extensionAmount = 0.0.obs;
  final checkedClose = false.obs;
  final checkLoanExtension = false.obs;
  final scheduleLoading = false.obs;
  final customLoading = false.obs;
  final closeLoading = false.obs;

  final checkClose = IOButtonModel(
    label: 'Зээл хаах дүн харах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
  ).obs;
  final loanExtension = IOButtonModel(
    label: 'Зээл сунгах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
  ).obs;
  LoanPayInfoController({required this.loan});

  bool get isExpired => loan.isExpired;

  @override
  void onInit() {
    super.onInit();
    if (isExpired) {
      getCloseAmount();
    }
  }

  Future getCloseAmount() async {
    isInitialLoading.value = true;
    checkClose.update((val) {
      val?.isLoading = true;
    });
    final response = await LoanApi().getLoanCloseAmount(code: loan.acntCode);
    isInitialLoading.value = false;
    checkClose.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      checkedClose.value = true;
      closeAmount.value = response.data['totalBal'].ddoubleValue;
    } else {
      showError(text: response.message);
    }
  }

  Future getExtensionAmount() async {
    isInitialLoading.value = true;
    loanExtension.update((val) {
      val?.isLoading = true;
    });
    final response = await LoanApi().getLoanCloseAmount(code: loan.acntCode);
    isInitialLoading.value = false;
    loanExtension.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      checkLoanExtension.value = true;
      extensionAmount.value = response.data['totalBal'].ddoubleValue;
    } else {
      showError(text: response.message);
    }
  }

  void onPay(LoanPayType loanType, PayType payType) {
    Get.focusScope?.unfocus();
    switch (loanType) {
      case LoanPayType.schedule:
        onScheduleLoan();
        break;
      case LoanPayType.custom:
        onCustomsLoan();
        break;
      case LoanPayType.close:
        onCloseLoan();
        break;
      case LoanPayType.closeLine:
        onCloseLineLoan();
        break;
      case LoanPayType.extension:
        onExtensionLoan();
        break;
    }
  }

  Future onExtensionLoan() async {
    final result = await showWarning(
      text: 'Та сунгалт хийхдээ итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    final amount = loan.nextSchdTotal;

    isLoading.value = true;
    checkLoanExtension.value = true;

    final response = await LoanApi().payLoan(
      code: loan.acntCode,
      amount: amount,
    );

    isLoading.value = false;
    checkLoanExtension.value = false;

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

  Future onScheduleLoan() async {
    final result = await showWarning(
      text: 'Та хуваарийн дагуу төлөхдөө итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    final amount = loan.nextSchdTotal;

    isLoading.value = true;
    scheduleLoading.value = true;

    final response = await LoanApi().payLoan(
      code: loan.acntCode,
      amount: amount,
    );

    isLoading.value = false;
    scheduleLoading.value = false;

    if (response.isSuccess) {
      onResult(
        data: response.data,
        amount: amount,
        payType: LoanPayType.schedule,
      );
    } else {
      showError(text: response.message);
    }
  }

  Future onCustomsLoan() async {
    final result = await showWarning(
      text: 'Та өөр дүнгээр төлөхдөө итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    final amount = customAmount.value;

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

  Future onCloseLineLoan() async {
    final result = await showWarning(
      text: 'Та зээл хаахдаа итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    final amount = closeAmount.value;

    isLoading.value = true;
    closeLoading.value = true;

    final response = await LoanApi().payLoan(
      code: loan.acntCode,
      amount: amount,
    );

    isLoading.value = false;
    closeLoading.value = false;

    if (response.isSuccess) {
      onResult(
        data: response.data,
        amount: amount,
        payType: LoanPayType.closeLine,
      );
    } else {
      showError(text: response.message);
    }
  }

  Future onCloseLoan() async {
    final result = await showWarning(
      text: 'Та зээл хаахдаа итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );
    if (result == null) return;
    final amount = closeAmount.value;

    isLoading.value = true;
    closeLoading.value = true;

    final response = await LoanApi().closeLoan(
      code: loan.acntCode,
      amount: amount,
    );

    isLoading.value = false;
    closeLoading.value = false;

    if (response.isSuccess) {
      onResult(data: response.data, amount: amount, payType: LoanPayType.close);
    } else {
      showError(text: response.message);
    }
  }

  void onBack() {
    Get.back();
    if (Get.isRegistered<LoanTabController>()) {
      Get.find<LoanTabController>().onRefresh();
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
      QpayInfoModel(title: 'Шимтгэл', value: fee.toCurrency()),
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
    onBack();
  }
}

enum LoanPayType { schedule, custom, close, closeLine, extension }
