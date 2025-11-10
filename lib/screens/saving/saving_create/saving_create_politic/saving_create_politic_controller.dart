import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCreatePoliticController extends IOController {
  final create = Get.arguments as SavingCreateModel;
  final relatedPerson = false.obs;
  final relatedMoney = false.obs;

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: true,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    ever(relatedPerson, (_) => checkValidation());
    ever(relatedMoney, (_) => checkValidation());
  }

  void onTapPerson(bool value) {
    relatedPerson.value = value;
  }

  void onTapMoney(bool value) {
    relatedMoney.value = value;
  }

  void checkValidation() {
    print('object');
    next.update((val) {
      val?.isEnabled =
          relatedPerson.value == false && relatedMoney.value == false;
    });
  }

  Future onTapNext() async {
    isLoading.value = true;
    next.update((val) {
      val?.isLoading = true;
    });
    final response = await SavingApi().createSaving(
      model: create,
    );
    isLoading.value = false;
    next.update((val) {
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
          title: 'Итгэлцлийн нэр',
          value: create.name,
        ),
        QpayInfoModel(
          title: 'Итгэлцлийн мөнгөн дүн',
          value: create.firstAmount.toCurrency(),
        ),
        if (fee > 0)
          QpayInfoModel(
            title: 'Шимтгэл',
            value: fee.toCurrency(),
          ),
        QpayInfoModel(
          title: 'Нийт төлөх дүн',
          value: (fee + create.firstAmount).toCurrency(),
        ),
      ];
      final qpay = QpayScreenModel(
        title: 'Итгэлцэл',
        invoice: invoice,
        info: info,
        urls: urls,
      );

      final result = await AppRoute.toQpay(model: qpay);
      if (result == null) return;

      await AppRoute.toSuccess(
        title: 'Танд баяр хүргэе.',
        description: 'Таны итгэлцэл амжилттай нээгдлээ',
      );
      Get.until((route) => route.isFirst);

      if (Get.isRegistered<SavingTabController>()) {
        Get.find<SavingTabController>().onRefresh();
      }
    } else {
      showError(text: response.message);
    }
  }
}
