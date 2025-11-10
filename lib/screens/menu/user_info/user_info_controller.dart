import 'package:bichil/library/library.dart';

class UserInfoController extends IOController {
  final deleteButton = IOButtonModel(
    label: 'Бүртгэл устгах',
    type: IOButtonType.secondary,
    size: IOButtonSize.medium,
    enabledBackgroundColor: IOColors.errorSecondary,
    enabledForegroundColor: IOColors.errorPrimary,
    prefixIcon: 'trash.svg',
  );

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
}
