import 'package:bichil/library/library.dart';
import 'package:get/get.dart';

class UserInfoController extends IOController {
  final deleteButton = IOButtonModel(
    label: 'Бүртгэл устгах',
    type: IOButtonType.secondary,
    size: IOButtonSize.medium,
    enabledBackgroundColor: IOColors.errorSecondary,
    enabledForegroundColor: IOColors.errorPrimary,
    prefixIcon: 'trash.svg',
  );
  final relatedPersons = <UserRelatedModel>[].obs;
  void onChangePhone() {
    MenuRoute.toChangePhoneNumber();
  }

  void onChangeEmail() async {
    MenuRoute.toChangeEmail();
  }

  void onChangeBank() async {
    MenuRoute.toChangeBank();
  }

  Future onTapDelete() async {
    MenuRoute.toUserDelete();
  }

  Future onChangeRelate(UserRelatedModel person) async {
    MenuRoute.toChangeRelate(person: person);
  }

  @override
  void onInit() {
    super.onInit();
    getRelated();
  }

  Future getRelated() async {
    isInitialLoading.value = true;
    late IOResponse response;
    response = await UserApi().getUserRelated();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      final relatedData = response.data;

      relatedPersons.clear();
      for (var item in relatedData.listValue) {
        relatedPersons.add(
          UserRelatedModel(
            id: item['id'].integerValue,
            name: item['name'].stringValue,
            relation: item['relation'].stringValue,
            phone: item['phone'].stringValue,
            isActive: item['is_active'].booleanValue,
          ),
        );
      }
    } else {
      Get.back();
      showError(text: response.message);
    }
  }
}

class UserRelatedModel {
  final int id;
  final String name;
  final String relation;
  final String phone;
  final bool isActive;
  UserRelatedModel({
    required this.id,
    required this.name,
    required this.relation,
    required this.phone,
    required this.isActive,
  });
}
