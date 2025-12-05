import 'package:get/get.dart';
import 'package:bichil/library/library.dart';

class IOController extends GetxController {
  final isInitialLoading = false.obs;
  final isLoading = false.obs;
  final user = HelperManager.user.obs;
  final count = HelperManager.notifCount.obs;
  bool get isLogged => HelperManager.isLogged;

  Future<bool?> showSuccess({
    required String text,
    String? titleText,
    String? buttonText,
    bool dismissable = true,
  }) {
    return IOAlert(
      type: IOAlertType.success,
      titleText: titleText,
      bodyText: text,
      acceptText: buttonText ?? 'Хаах',
      dismissable: dismissable,
    ).show();
  }

  Future<bool?> showError({
    required String text,
    String? titleText,
    String? buttonText,
  }) {
    return IOAlert(
      type: IOAlertType.error,
      titleText: titleText,
      bodyText: text,
      acceptText: buttonText ?? 'Хаах',
    ).show();
  }

  Future<bool?> showWarning({
    required String text,
    String? titleText,
    String? acceptText,
    String? cancelText,
  }) {
    return IOAlert(
      type: IOAlertType.warning,
      titleText: titleText,
      bodyText: text,
      acceptText: acceptText,
      cancelText: cancelText,
    ).show();
  }

  void onTapNotfication() async {
    if (isLogged) {
      AppRoute.toNotification();
    } else {
      final result = await showWarning(
        text: 'Та нэвтэрж орсноор мэдэгдэл харах боломжтой',
        cancelText: 'Хаах',
        acceptText: 'Тийм',
      );
      if (result == null) return;
      IOPages.toInitial();
    }
  }

  @override
  void onInit() {
    super.onInit();
    UserStoreManager.shared.store.listenKey(kUser, (_) {
      user.value = HelperManager.user;
    });
    UserStoreManager.shared.store.listenKey(kNotificationCount, (_) {
      count.value = HelperManager.notifCount;
    });
  }
}
