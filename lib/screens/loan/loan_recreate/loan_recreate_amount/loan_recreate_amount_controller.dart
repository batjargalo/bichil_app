import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanRecreateAmountController extends IOController {
  final LoanInfoModel item;
  final amount = 0.0.obs;

  final button = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  LoanRecreateAmountController({required this.item});

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
    if (item.availComBal == 0) {
      showError(
        text:
            'Зээл авах боломжгүй байна. Та зээлийн боломжит үлдэгдлээ нэмснээр зээл авах боломжтой болно.',
      );
      return;
    }
    if (amount.value > item.availComBal) {
      showError(
          text: '${item.availComBal.toCurrency()}-с ихгүй утга оруулна уу');
      return;
    }

    final pin = await AppRoute.toPin();
    if (pin == null) return;

    isLoading.value = true;
    button.update((val) {
      val?.isLoading = true;
    });

    final model = LoanRecreateModel(
      amount: amount.value,
      accountNo: item.acntCode,
      pinCode: pin,
      term: 0,
      payDay: 0,
    );
    final response = await LoanApi().recreate(model: model);

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
    } else {
      showError(text: response.message);
    }
  }
}
