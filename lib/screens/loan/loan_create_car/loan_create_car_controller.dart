import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateCarController extends IOController {
  final types = ['Улсын дугаартай', 'Гаалийн бичигтэй'];
  final loans = ['Худалдан авах зээл', 'Барьцаалсан зээл'];

  late final type = types.first.obs;
  late final loan = loans.first.obs;

  final carNo = IOTextfieldModel(
    label: 'Улсын дугаар',
    placeholder: '0000AAA',
    maxLength: 7,
    validators: [ValidatorType.car],
    inputFormatters: [
      UpperCaseTextFormatter(),
    ],
  );

  final frameNo = IOTextfieldModel(
    label: 'Арлын дугаар оруулана уу.',
    validators: [ValidatorType.notEmpty],
    keyboardType: const TextInputType.numberWithOptions(
      signed: true,
    ),
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
    ever(type, (_) => checkValidation());
    carNo.status.addListener(checkValidation);
    frameNo.status.addListener(checkValidation);
  }

  void checkValidation() {
    if (type.value == 'Улсын дугаартай') {
      send.update((val) {
        val?.isEnabled = carNo.isValid;
      });
    } else {
      send.update((val) {
        val?.isEnabled = frameNo.isValid;
      });
    }
  }

  Future onTapSend() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    send.update((val) => val?.isLoading = true);

    final no = type.value == 'Улсын дугаартай' ? carNo.value : frameNo.value;

    final response = await LoanApi().sendCarRequest(
      registerType: type.value,
      loanType: loan.value,
      carNo: no,
    );

    isLoading.value = false;
    send.update((val) => val?.isLoading = false);

    if (response.isSuccess) {
      final screen = LoanCreateCarSuccess(
        title: response.message,
        data: response.data,
      );
      await Get.to(() => screen);
      Get.until((route) => route.isFirst);
      MenuRoute.toBranch();

      if (Get.isRegistered<LoanTabController>()) {
        Get.find<LoanTabController>().onRefresh();
      }
    } else {
      showError(text: response.message);
    }
  }
}
