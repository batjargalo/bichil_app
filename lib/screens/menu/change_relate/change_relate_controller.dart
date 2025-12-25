import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeRelateController extends IOController {
  final UserRelatedModel person;
  ChangeRelateController({required this.person});
  List<RelatedModel> relations = [
    RelatedModel(value: '1', relation: 'Эцэг/эх/'),
    RelatedModel(value: '2', relation: 'Ах/эгч/'),
    RelatedModel(value: '3', relation: 'Нөхөр/эхнэр/'),
    RelatedModel(value: '4', relation: 'Хүү/охин/'),
    RelatedModel(value: '5', relation: 'Найз'),
    RelatedModel(value: '6', relation: 'Бусад'),
  ];

  final selectRelation = IODropdownModel<RelatedModel>(
    label: 'Хэн болох',
    validators: [ValidatorType.notEmpty],
    sheetTitle: 'Сонгох',
  );

  final name = IOTextfieldModel(
    label: 'Нэр',
    validators: [ValidatorType.notEmpty],
  );

  final phone = IOTextfieldModel(
    label: 'Холбоо барих утас',
    maxLength: 8,
    validators: [ValidatorType.phone],
    keyboardType: TextInputType.phone,
  );

  int get relationId => person.id;
  String get relationName => name.value;
  String get relationPhone => phone.value;
  String get relationValue => relations
      .firstWhere(
        (r) => r.relation == selectRelation.value,
        orElse: () => RelatedModel(value: "", relation: ""),
      )
      .value;
  final save = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    selectRelation.setData(
      relations
          .firstWhere(
            (r) => r.value == person.relation,
            orElse: () => RelatedModel(value: "", relation: ""),
          )
          .relation,
    );
    name.setData(person.name);
    phone.setData(person.phone);
    selectRelation.status.addListener(checkValidation);
    name.status.addListener(checkValidation);
    phone.status.addListener(checkValidation);
  }

  void checkValidation() {
    save.update((val) {
      val?.isEnabled = selectRelation.isValid && name.isValid && phone.isValid;
    });
  }

  Future onTapSelect() async {
    final result = await RelateSheet(relation: relations).show();
    Get.focusScope?.unfocus();
    if (result == null) return;
    selectRelation.setDropdownValue(
      IODropdownSheetModel(name: result.relation, value: result),
    );
  }

  Future onTapSave() async {
    isLoading.value = true;
    save.update((val) => val?.isLoading = true);
    final response = await UserApi().addRelate(
      name: relationName,
      phone: relationPhone,
      relation: relationValue,
    );

    if (response.isSuccess) {
      await SessionManager.shared.getUser();
      await Get.find<UserInfoController>().getRelated();
      Get.back(result: true);
    } else {
      stopLoading();
      showError(text: response.message);
    }
  }

  Future onTapUpdate() async {
    isLoading.value = true;
    save.update((val) => val?.isLoading = true);
    final response = await UserApi().changeRelate(
      id: relationId,
      name: relationName,
      phone: relationPhone,
      relation: relationValue,
    );

    if (response.isSuccess) {
      await SessionManager.shared.getUser();
      await Get.find<UserInfoController>().getRelated();
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
