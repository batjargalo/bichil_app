import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class BranchListController extends IOController {
  final countryItem = <BranchCountryModel>[].obs;
  final branchItem = <BranchModel>[].obs;

  final country = IODropdownModel<BranchCountryModel>(
    label: 'Хот сонгох',
    hasBorder: false,
    sheetTitle: '',
  );

  final city = IODropdownModel<BranchCityModel>(
    label: 'Дүүрэг сонгох',
    hasBorder: false,
    sheetTitle: '',
  );

  @override
  void onInit() {
    super.onInit();
    getCountry();
  }

  void setInitialData() {
    if (countryItem.isEmpty) return;
    final ub = countryItem
        .where((e) => e.name.toLowerCase() == 'улаанбаатар'.toLowerCase())
        .first;

    setCountry(ub);

    // if (ub.citydistrict.isEmpty) return;
    // final e = ub.citydistrict.first;
    // setCity(e);
    getBranches();
  }

  void setCountry(BranchCountryModel item) {
    final e = IODropdownSheetModel(
      name: item.name,
      value: item,
    );
    country.setDropdownValue(e);
  }

  void setCity(BranchCityModel item) {
    final e = IODropdownSheetModel(
      name: item.name,
      value: item,
    );
    city.setDropdownValue(e);
  }

  Future onTapCountry() async {
    Get.focusScope?.unfocus();
    final result = await BranchCountrySheet(
      title: 'Хот сонгох',
      names: countryItem.map((e) => e.name).toList(),
      counts: countryItem.map((e) => e.branchCount).toList(),
    ).show();

    if (result == null) return;

    final item = countryItem[result];
    setCountry(item);
    city.setDropdownValue(null);
    getBranches();
  }

  Future onTapCity() async {
    Get.focusScope?.unfocus();
    if (country.dropdownValue == null) return;
    final e = country.dropdownValue!.citydistrict;
    final isUb = country.dropdownValue!.name.toLowerCase() ==
        'улаанбаатар'.toLowerCase();
    final result = await BranchCountrySheet(
      title: isUb ? 'Дүүрэг сонгох' : 'Аймаг сонгох',
      names: e.map((e) => e.name).toList(),
      counts: e.map((e) => e.count).toList(),
    ).show();

    if (result == null) return;

    final item = e[result];
    setCity(item);
    getBranches();
  }

  Future getCountry() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getCountry();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      countryItem.value = response.data.listValue
          .map((e) => BranchCountryModel.fromJson(e))
          .toList();
      setInitialData();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future getBranches() async {
    isLoading.value = true;
    final response = await InfoApi().getBranches(
      countryId: country.dropdownValue?.id,
      cityId: city.dropdownValue?.id,
    );
    isLoading.value = false;
    if (response.isSuccess) {
      branchItem.value =
          response.data.listValue.map((e) => BranchModel.fromJson(e)).toList();
    }
  }
}
