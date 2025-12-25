import 'dart:math';

import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class DigitalLoanCreateAmountController extends IOController {
  final LoanLimitModel item;
  final amount = 0.0.obs;
  final term = 0.obs;
  final mountlyPayment = 0.0.obs;
  final totalPayment = 0.0.obs;
  final button = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;
  final selectedTerm = 0.obs;
  //

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
      case <= 500000:
        return duration1;
      case <= 1500000:
        return duration2;
      case <= 2500000:
        return duration3;
      case <= 3500000:
        return duration4;
      default:
        return duration5;
    }
  }

  //

  DigitalLoanCreateAmountController({required this.item});

  @override
  void onInit() {
    super.onInit();
    ever(amount, (value) {
      button.update((val) {
        val?.isEnabled = value != 0;
      });
    });
    everAll([amount, selectedTerm], (_) {
      if (selectedTerm.value <= 3) {
        final P = amount.value;
        final r = (0.48 / 365) * underMonth[selectedTerm.value];
        final n = 1;
        mountlyPayment.value =
            P * r * (pow(1 + r, n) as double) / ((pow(1 + r, n) as double) - 1);
        totalPayment.value = mountlyPayment.value * n;
      } else {
        final P = amount.value;
        late double B = P;
        late double interestSum = 0.0;
        final r = (0.48 / 365) * 30;
        final n = underMonth[selectedTerm.value];
        mountlyPayment.value =
            P *
            (r * (pow(1 + r, n) as double) / ((pow(1 + r, n) as double) - 1));

        for (int i = 0; i < n; i++) {
          final daysInMonth = DateTime(
            DateTime.now().year,
            DateTime.now().month + i + 1,
            0,
          ).day;
          final interest = B * (0.48 / 365 * daysInMonth);
          interestSum += interest;
          final principal = mountlyPayment.value - interest;
          B = B - principal;
        }

        totalPayment.value = interestSum + amount.value;
      }
    });
  }

  void onTapNext() async {
    if (item.loanLimit == 0) {
      showError(
        text:
            'Зээл авах боломжгүй байна. Та зээлийн боломжит үлдэгдлээ нэмснээр зээл авах боломжтой болно.',
      );
      return;
    }
    final userRelated = await UserApi().getUserRelated();
    if (userRelated.isSuccess) {
      final relatedData = userRelated.data;
      if (relatedData.listValue.length < 3) {
        toWarningUserInfo(
          titleText: 'Анхаарна уу?',
          text: "Та өөрийн ойр дотны 3 хүний мэдээллийг оруулна уу.",
          buttonText: 'Бүртгэлээ шинэчлэх',
        );
        return;
      }
    } else {
      showError(text: userRelated.message);
      return;
    }
    if (amount.value > item.loanLimit) {
      showError(text: '${item.loanLimit}-с ихгүй утга оруулна уу');
      return;
    }

    final pin = await AppRoute.toPin();
    if (pin == null) return;

    isLoading.value = true;
    button.update((val) {
      val?.isLoading = true;
    });

    final model = DigitalLoanCreateModel(
      amount: amount.value,
      term: term.value,
      pinCode: pin,
      payDay: 0,
    );
    final response = await LoanApi().createDigitalLoan(model: model);

    isLoading.value = false;
    button.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      await AppRoute.toSuccess(
        title: 'Амжилттай',
        description: response.message,
        buttonText: 'Дуусгах',
      );
      Get.until((route) => route.isFirst);
      if (Get.isRegistered<LoanTabController>()) {
        Get.find<LoanTabController>().onRefresh();
      }
    } else if (response.message == "Та гүйлгээний нууц үгээ тохируулна уу") {
      toWarning(
        titleText: 'Анхаарна уу?',
        text: response.message,
        buttonText: 'Нууц үг үүсгэх',
      );
    } else {
      showError(text: response.message);
    }
  }
}
