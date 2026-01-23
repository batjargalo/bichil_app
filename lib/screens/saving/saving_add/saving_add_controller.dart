import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingAddController extends IOController {
  final String code;
  final double minimumAmount;
  final amount = 0.0.obs;

  final qpay = IOButtonModel(
    label: 'Qpay',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
  ).obs;

  SavingAddController({required this.code, required this.minimumAmount});

  Future onTapAdd() async {
    Get.focusScope?.unfocus();
    if (amount.value < minimumAmount) {
      showError(text: 'Боломжит дүнгээс их дүн оруулна уу');
      return;
    }
    final result = await showWarning(
      text:
          'Та итгэлцэлд ${amount.value.toCurrency()} нэмэхдээ итгэлтэй байна уу',
      acceptText: 'Тийм',
      cancelText: 'Хаах',
    );

    if (result == null) return;

    isLoading.value = true;
    qpay.update((val) {
      val?.isLoading = true;
    });
    final response = await SavingApi().addAmountSaving(
      code: code,
      amount: amount.value,
    );
    isLoading.value = false;
    qpay.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      final fee = response.data['fee'].ddoubleValue;
      final invoice = response.data['local_invoice_number'].stringValue;
      final urls = response.data['urls'].listValue
          .map((e) => QpayModel.fromJson(e))
          .toList();
      final info = [
        QpayInfoModel(
          title: 'Төлөх мөнгөн дүн',
          value: amount.value.toCurrency(),
        ),
        QpayInfoModel(title: 'Qpay хураамж', value: fee.toCurrency()),
        QpayInfoModel(
          title: 'Нийт төлөх дүн',
          value: (fee + amount.value).toCurrency(),
        ),
      ];
      final qpay = QpayScreenModel(
        title: 'Итгэлцэл нэмэх',
        invoice: invoice,
        info: info,
        urls: urls,
      );

      final result = await AppRoute.toQpay(model: qpay);
      if (result == null) return;
      await AppRoute.toSuccess(
        title: 'Амжилттай',
        description: 'Таны итгэлцэл нэмэгдлээ.',
      );
      Get.back();
      if (Get.isRegistered<SavingTabController>()) {
        Get.find<SavingTabController>().onRefresh();
      }
      if (Get.isRegistered<SavingDetailController>()) {
        Get.find<SavingDetailController>().getInfo();
      }
    } else {
      showError(text: response.message);
    }
  }
}
