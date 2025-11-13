import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class DigitalLoanCreateAmountController extends IOController {
  final LoanLimitModel item;
  final amount = 0.0.obs;
  final term = 0.obs;

  final button = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  DigitalLoanCreateAmountController({required this.item});

  @override
  void onInit() {
    super.onInit();
    ever(amount, (value) {
      button.update((val) {
        val?.isEnabled = value != 0;
      });
    });
  }

  void onTapNext() async {
    if (item.loanLimit == 0) {
      showError(text: 'Зээл авах боломжгүй байна. Та зээлийн боломжит үлдэгдлээ нэмснээр зээл авах боломжтой болно.');
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

    final model = DigitalLoanCreateModel(amount: amount.value, term: term.value, pinCode: pin, payDay: 0);
    final response = await LoanApi().createDigitalLoan(model: model);

    isLoading.value = false;
    button.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      await AppRoute.toSuccess(title: 'Амжилттай', description: response.message, buttonText: 'Дуусгах');
      Get.until((route) => route.isFirst);
      if (Get.isRegistered<LoanTabController>()) {
        Get.find<LoanTabController>().onRefresh();
      }
    } else {
      showError(text: response.message);
    }
  }
}
