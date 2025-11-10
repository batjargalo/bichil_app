import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCloseAmountController extends IOController {
  final SavingCloseModel model;
  final amount = 0.0.obs;

  final button = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  SavingCloseAmountController({required this.model});

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
    if (amount.value > model.saving.availBal) {
      showError(text: 'Итгэлцлийн авах дээд дүнгээс бага утга оруулна уу');
      return;
    }

    if (amount.value < model.minimumAmount) {
      showError(text: 'Итгэлцлийн авах доод дүнгээс их утга оруулна уу');
      return;
    }

    model.closeAmount = amount.value;

    SavingRoute.toCloseConfirm(model: model);
  }
}
