import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoanCalculatorFormController extends IOController {
  final LoanInfoModel? loan;
  final bool hasAppBar;

  LoanCalculatorFormController({this.loan, required this.hasAppBar});

  final formatter = CurrencyTextInputFormatter.currency(
    symbol: '',
    decimalDigits: 0,
  );

  late final amount = IOTextfieldModel(
    label: 'Зээлийн дүн',
    inputFormatters: [formatter],
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.number,
  );

  final period = IOTextfieldModel(
    label: 'Хугацаа (сараар)',
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.number,
  );

  final rate = IOTextfieldModel(
    label: 'Зээлийн хүү (жилээр)',
    validators: [ValidatorType.notEmpty],
    keyboardType: const TextInputType.numberWithOptions(
      decimal: true,
    ),
  );

  // final type = IODropdownModel<LoanProductModel>(
  //   label: 'Зээлийн төрөл сонгох',
  //   sheetTitle: 'Зээлийн төрөл сонгох',
  // );

  final loans = <IODropdownSheetModel<LoanProductModel>>[].obs;
  final types = [
    LoanCalculatorRepaymentType.fixed,
    LoanCalculatorRepaymentType.equalprincipal,
  ];

  final selectedType = LoanCalculatorRepaymentType.fixed.obs;

  final button = IOButtonModel(
    label: 'Тооцоолох',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
    isExpanded: true,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    amount.status.addListener(chechValidation);
    period.status.addListener(chechValidation);
    rate.status.addListener(chechValidation);
    // setInitialData();
    getLoans();
  }

  void setInitialData() {
    // if (loan == null) return;
    // final value = IODropdownSheetModel(
    //   name: loan!.prodName,
    //   value: loan!,
    // );
    // type.setDropdownValue(value);
  }

  void chechValidation() {
    button.update((val) {
      val?.isEnabled = formatter.getUnformattedValue() != 0 &&
          period.isValid &&
          rate.isValid;
    });
  }

  // void onSelectType(IODropdownSheetModel<LoanProductModel> item) {
  //   Get.focusScope?.unfocus();
  //   type.setDropdownValue(item);
  // }

  Future getLoans() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getSubProducts(id: 0);
    isInitialLoading.value = false;

    if (response.isSuccess) {
      loans.value = response.data.listValue
          .map((e) => LoanProductModel.fromJson(e))
          .map((e) => IODropdownSheetModel(name: e.name, value: e))
          .toList();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future onTapCalculate() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    button.update((val) {
      val?.isLoading = true;
    });

    final model = LoanCalculatorModel(
      amount: formatter.getUnformattedValue().toInt(),
      month: int.tryParse(period.value) ?? 0,
      rate: double.tryParse(rate.value) ?? 0,
      // loan: type.dropdownValue!,
      type: selectedType.value,
    );

    final response = await LoanApi().getCalculate(model: model);

    isLoading.value = false;
    button.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      final items = response.data['schedule'].listValue
          .map((e) => LoanCalculatorResultModel.fromJson(e))
          .toList();
      model.items = items;
      model.rate = response.data['interest'].ddoubleValue;
      LoanRoute.toCalculatorResult(model: model);
    } else {
      showError(text: response.message);
    }
  }
}
