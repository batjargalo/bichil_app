import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class MenuTabController extends IOController {
  final tab = Get.find<TabBarController>();
  final isBiometricEnabled = HelperManager.isSavedBiometricOnUser.obs;

  List get items => [
    if (isLogged)
      MenuTabModel(
        title: 'Хэрэглэгчийн мэдээлэл',
        items: [
          MenuTabItemModel(type: MenuTabItemType.contract),
          MenuTabItemModel(type: MenuTabItemType.loanHistory),
          MenuTabItemModel(type: MenuTabItemType.savingHistory),
          // MenuTabItemModel(type: MenuTabItemType.insurane),
        ],
      ),
    if (isLogged)
      MenuTabModel(
        title: 'Тохиргоо',
        items: [
          MenuTabItemModel(type: MenuTabItemType.changePassword),
          MenuTabItemModel(type: MenuTabItemType.changePin),
          if (BiometricManager.shared.isAutenticated)
            MenuTabItemModel(
              type: MenuTabItemType.biometric,
              value: isBiometricEnabled.value,
            ),
        ],
      ),
    MenuTabModel(
      title: 'Бусад',
      items: [
        MenuTabItemModel(type: MenuTabItemType.news),
        MenuTabItemModel(type: MenuTabItemType.operator),
        MenuTabItemModel(type: MenuTabItemType.branch),
        MenuTabItemModel(type: MenuTabItemType.calculator),
        MenuTabItemModel(type: MenuTabItemType.faq),
        MenuTabItemModel(type: MenuTabItemType.terms),
        MenuTabItemModel(type: MenuTabItemType.policy),
      ],
    ),
  ];

  final logoutButton = IOButtonModel(
    label: 'Системээс гарах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    prefixIcon: 'logout.svg',
    enabledBackgroundColor: IOColors.errorSecondary,
    enabledForegroundColor: IOColors.errorPrimary,
  );

  final signInButton = IOButtonModel(
    label: 'Нэвтрэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
  );

  @override
  void onInit() {
    super.onInit();
    UserStoreManager.shared.store.listenKey(kBiometricWithUser, (_) {
      isBiometricEnabled.value = HelperManager.isSavedBiometricOnUser;
      refresh();
    });
  }

  void onTapItem(MenuTabItemType type, bool? value) {
    switch (type) {
      case MenuTabItemType.contract:
        LoanRoute.toSignedContract();
        break;
      case MenuTabItemType.loanHistory:
        LoanRoute.toHistoryList();
        break;
      case MenuTabItemType.savingHistory:
        SavingRoute.toHistoryList();
        break;
      case MenuTabItemType.changePassword:
        MenuRoute.toChangePassword();
        break;
      case MenuTabItemType.changePin:
        MenuRoute.toChangePin();
        break;
      case MenuTabItemType.biometric:
        if (value != null) {
          onChangeBiometric(value);
        }
        break;

      case MenuTabItemType.news:
        MenuRoute.toNewsPage();
        break;
      case MenuTabItemType.operator:
        MenuRoute.toContact();
        break;
      case MenuTabItemType.branch:
        MenuRoute.toBranch();
        break;
      case MenuTabItemType.calculator:
        MenuRoute.toCalculator();
        break;
      case MenuTabItemType.faq:
        MenuRoute.toFaq();
        break;
      case MenuTabItemType.terms:
        MenuRoute.toTerms();
        break;
      case MenuTabItemType.policy:
        MenuRoute.toWeb(
          title: MenuTabItemType.policy.title,
          url: '$domain/api/info/privacy-policy',
        );
        break;
    }
  }

  void onTapUser() {
    MenuRoute.toUserInfo();
  }

  Future onChangeBiometric(bool value) async {
    await UserStoreManager.shared.write(kBiometricWithUser, value);
    isBiometricEnabled.value = HelperManager.isSavedBiometricOnUser;
    refresh();
  }

  Future onTapLogout() async {
    final result = await showWarning(
      titleText: 'Системээс гарах',
      text: 'Та системээс гарахдаа итгэлтэй байна уу?',
      cancelText: 'Цуцлах',
      acceptText: 'Гарах',
    );
    if (result == null) return;
    await SessionManager.shared.logout();
  }

  Future onTapSignIn() async {
    IOPages.toInitial();
  }
}
