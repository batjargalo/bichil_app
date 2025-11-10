import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class LoanCreatePropertyController extends IOController {
  final types = ['Орон сууц', 'Хашаа байшин', 'Дулаан зогсоол'];
  final rooms = ['1', '2', '3', '4', '5+'];
  // final regions = ['Улаанбаатар', 'Орон нутаг'];
  final countryItem = <BranchCountryModel>[].obs;
  final districtItem = <IODropdownSheetModel<BranchCityModel>>[].obs;
  final soumItem = <IODropdownSheetModel<BranchCityModel>>[].obs;

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

  final landSize = IOTextfieldModel(
    label: 'Газрын хэмжээ мкв',
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.number,
  );

  final size = IOTextfieldModel(
    label: 'Талбайн хэмжээ мкв',
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.number,
  );

  final district = IODropdownModel<BranchCityModel>(
    label: 'Дүүрэг/Аймаг сонгох',
    hasBorder: false,
    sheetTitle: 'Дүүрэг/Аймаг сонгох',
  );

  final soum = IODropdownModel<BranchCityModel>(
    label: 'Хороо/Сум сонгох',
    hasBorder: false,
    sheetTitle: 'Хороо/Сум сонгох',
  );

  final send = IOButtonModel(
    label: 'Илгээх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  int get amountVal => formatter.getUnformattedValue().toInt();
  late final type = types.first.obs;
  late final room = rooms.first.obs;
  late final country = BranchCountryModel.fromJson(JSON.nil).obs;

  @override
  void onInit() {
    super.onInit();
    getCountry();
    amount.controller.addListener(checkValidation);
    landSize.status.addListener(checkValidation);
    size.status.addListener(checkValidation);
    ever(type, (_) => checkValidation());
  }

  void checkValidation() {
    final isValidLandSize =
        type.value == 'Хашаа байшин' ? landSize.isValid : true;

    send.update((val) {
      val?.isEnabled = amountVal != 0 &&
          isValidLandSize &&
          size.isValid &&
          district.dropdownValue != null &&
          soum.dropdownValue != null;
    });
  }

  Future getCountry() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getCountry();

    if (response.isSuccess) {
      countryItem.value = response.data.listValue
          .map((e) => BranchCountryModel.fromJson(e))
          .toList();
      country.value = countryItem.first;
      await getDistrict();
      isInitialLoading.value = false;
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future getDistrict() async {
    final countryId = country.value.id;
    final response = await InfoApi().getDistrict(id: countryId);
    if (response.isSuccess) {
      districtItem.value = response.data.listValue
          .map((e) => BranchCityModel.fromJson(e))
          .map((e) => IODropdownSheetModel(name: e.name, value: e))
          .toList();
    }
  }

  Future getSoum() async {
    final districtId = district.dropdownValue?.id;
    if (districtId == null) return;
    final response = await InfoApi().getSoum(id: districtId);
    if (response.isSuccess) {
      soumItem.value = response.data.listValue
          .map((e) => BranchCityModel.fromJson(e))
          .map((e) => IODropdownSheetModel(name: e.name, value: e))
          .toList();
    }
  }

  Future onSelectCountry(BranchCountryModel value) async {
    country.value = value;
    district.setDropdownValue(null);
    soum.setDropdownValue(null);
    getDistrict();
    checkValidation();
  }

  Future onSelectDistrict(IODropdownSheetModel<BranchCityModel> value) async {
    Get.focusScope?.unfocus();
    district.setDropdownValue(value);
    soum.setDropdownValue(null);
    getSoum();
    checkValidation();
  }

  Future onTapSoum(IODropdownSheetModel<BranchCityModel> value) async {
    Get.focusScope?.unfocus();
    soum.setDropdownValue(value);
    checkValidation();
  }

  Future onTapSend() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    send.update((val) => val?.isLoading = true);
    final data = {
      'requested_amount': amountVal,
      'property_type': type.value,
      'property_size': size.value,
      'property_room_count': room.value,
      'property_land_size': landSize.value,
      'property_address_type': country.value.name,
      'property_address_district': district.dropdownValue!.name,
      'property_address_horoo': soum.dropdownValue!.name,
    };
    final response = await LoanApi().sendPropertyRequest(
      data: data,
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
