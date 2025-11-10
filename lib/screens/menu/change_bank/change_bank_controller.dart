import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeBankController extends IOController {
  List<BankModel> banks = [];

  final accBank = IODropdownModel<BankModel>(
    label: 'Банк',
    validators: [ValidatorType.notEmpty],
    sheetTitle: 'Банк',
  );

  final accNumber = IOTextfieldModel(
    label: 'Дансны дугаар',
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.number,
  );

  final accName = IOTextfieldModel(
    label: 'Эзэмшигчийн нэр',
    validators: [ValidatorType.notEmpty],
    isEnabled: false,
  );

  int get bankId => accBank.dropdownValue!.id;
  String get accountNumber => accNumber.value;
  String get accountName => accName.value;

  final save = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    accBank.status.addListener(checkValidation);
    accNumber.status.addListener(checkValidation);
    accName.status.addListener(checkValidation);
    accNumber.focusNode.addListener(checkAccount);
    getBanks();
  }

  void checkValidation() {
    save.update((val) {
      val?.isEnabled = accBank.isValid && accNumber.isValid && accName.isValid;
    });
  }

  Future getBanks() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getBanks();

    if (response.isSuccess) {
      banks =
          response.data.listValue.map((e) => BankModel.fromJson(e)).toList();
      isInitialLoading.value = false;
    } else {
      isInitialLoading.value = false;
      showError(text: response.message);
    }
  }

  Future checkAccount() async {
    if (accNumber.focusNode.hasFocus) return;
    if (accBank.isValid && accNumber.isValid) {
      final response = await InfoApi().checkBank(
        bankId: accBank.dropdownValue!.id,
        account: accNumber.value,
      );
      if (response.isSuccess) {
        final name = response.data['account_name'].stringValue;
        accName.setData(name);
      } else {
        accName.setData('');
        showError(text: response.message);
      }
    }
  }

  Future onTapBanks() async {
    final result = await BankSheet(banks: banks).show();
    Get.focusScope?.unfocus();
    if (result == null) return;
    accBank.setDropdownValue(
      IODropdownSheetModel(
        name: result.name,
        value: result,
      ),
    );
    checkAccount();
  }

  Future onTapSave() async {
    isLoading.value = true;
    save.update((val) => val?.isLoading = true);

    final response = await UserApi().changeBank(
      bankId: bankId,
      account: accountNumber,
    );

    if (response.isSuccess) {
      await SessionManager.shared.getUser();
      Get.back(result: true);
    } else {
      stopLoading();
      showError(text: response.message);
    }
  }

  void stopLoading() {
    isLoading.value = false;
    save.update((val) => val?.isLoading = false);
  }
}
