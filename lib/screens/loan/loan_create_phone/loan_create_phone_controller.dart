import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreatePhoneController extends IOController {
  int get amountVal => formatter.getUnformattedValue().toInt();

  final formatter = CurrencyTextInputFormatter.currency(
    symbol: '',
    decimalDigits: 0,
  );

  late final amount = IOTextfieldModel(
    label: 'Таны хүсэж буй зээлийн хэмжээ ₮',
    inputFormatters: [formatter],
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.number,
  );

  final phone = IOTextfieldModel(
    label: 'Утасны дугаар',
    validators: [ValidatorType.phone],
    keyboardType: TextInputType.phone,
    maxLength: 8,
  );

  final send = IOButtonModel(
    label: 'Илгээх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    amount.status.addListener(checkValidation);
    phone.status.addListener(checkValidation);
  }

  @override
  void onClose() {
    amount.status.removeListener(checkValidation);
    phone.status.removeListener(checkValidation);
    super.onClose();
  }

  void checkValidation() {
    send.update((val) {
      val?.isEnabled = amountVal != 0 && phone.isValid;
    });
  }

  Future onTapSend() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    send.update((val) => val?.isLoading = true);

    final response = await LoanApi().sendPhoneRequest(
      amount: amountVal,
      phone: phone.value,
    );

    isLoading.value = false;
    send.update((val) => val?.isLoading = false);

    if (response.isSuccess) {
      await AppRoute.toSuccess(
        title: 'Амжилттай',
        description: response.message,
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
