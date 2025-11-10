import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCreateFormController extends IOController {
  final LoanProductModel item;

  LoanCreateFormController({required this.item});

  final lastName = IOTextfieldModel(
    label: 'Овог',
    validators: [ValidatorType.notEmpty],
  );
  final firstName = IOTextfieldModel(
    label: 'Нэр',
    validators: [ValidatorType.notEmpty],
  );
  final phone = IOTextfieldModel(
    label: 'Утасны дугаар',
    validators: [ValidatorType.phone],
    maxLength: 8,
    keyboardType: TextInputType.phone,
  );
  final email = IOTextfieldModel(
    label: 'Мэйл хаяг',
    validators: [ValidatorType.email],
    keyboardType: TextInputType.emailAddress,
  );
  final car = IOTextfieldModel(
    label: 'Автомашины улсын дугаар/арлын дугаар',
    validators: [ValidatorType.notEmpty],
    inputFormatters: [UpperCaseTextFormatter()],
  );
  final branch = IODropdownModel<BranchModel>(
    label: 'Өөрт ойрхон салбар сонгох',
    sheetTitle: 'Өөрт ойрхон салбар сонгох',
    validators: [ValidatorType.notEmpty],
  );

  final button = IOButtonModel(
    label: 'Илгээх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
    isExpanded: true,
  ).obs;

  bool get isCarLoan => item.collateralType == 'car';
  final branches = <IODropdownSheetModel<BranchModel>>[].obs;

  @override
  void onInit() {
    super.onInit();
    lastName.status.addListener(checkValidation);
    firstName.status.addListener(checkValidation);
    phone.status.addListener(checkValidation);
    email.status.addListener(checkValidation);
    car.status.addListener(checkValidation);
    branch.status.addListener(checkValidation);
    setInitialData();
    getBranches();
  }

  void setInitialData() {
    if (!HelperManager.isLogged) return;
    lastName.setData(user.value.lastName);
    firstName.setData(user.value.firstName);
    phone.setData(user.value.phone);
    email.setData(user.value.email);
  }

  void checkValidation() {
    final isValidCar = isCarLoan ? car.isValid : true;
    button.update((val) {
      val?.isEnabled = lastName.isValid &&
          firstName.isValid &&
          phone.isValid &&
          branch.isValid &&
          isValidCar;
    });
  }

  Future onSelectBranches(IODropdownSheetModel<BranchModel> item) async {
    branch.setDropdownValue(item);
    Get.focusScope?.unfocus();
  }

  Future getBranches() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getBranches();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      branches.value = response.data.listValue.map((e) {
        final branch = BranchModel.fromJson(e);
        return IODropdownSheetModel(name: branch.title, value: branch);
      }).toList();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future senRequest() async {
    isLoading.value = true;
    button.update((val) {
      val?.isLoading = true;
    });
    final model = LoanCreateModel(
      product: item.id,
      firstNme: firstName.value,
      lastName: lastName.value,
      phone: phone.value,
      email: email.value,
      proofValue: car.value,
      nearBranch: branch.dropdownValue!.id,
    );
    final response = await InfoApi().sendProduct(model: model);
    isLoading.value = false;
    button.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      await AppRoute.toSuccess(
        title: 'Таны хүсэлтийг хүлээж авлаа',
        description: 'Бичил глобус тантай холбогдох болно.',
        buttonText: 'Нүүр хуудас руу очих',
      );
      Get.until((route) => route.isFirst);
    } else {
      showError(text: response.message);
    }
  }
}
