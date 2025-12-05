import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class AppRoute {
  static Future? toNotification() {
    return Get.to(() => const NotificationPageScreen());
  }

  static Future? toSuccess({required String title, required String description, String? buttonText}) {
    return Get.to(() => IOSuccessScreen(title: title, description: description, buttonText: buttonText));
  }

  static Future? toConfirm({
    required String title,
    required String description,
    String? confirmButtonText,
    String? cencelButtonText,
    Future? onConfirmed,
  }) {
    return Get.to(
      () => IOConfirmScreen(
        title: title,
        description: description,
        confirmButtonText: confirmButtonText,
        cencelButtonText: cencelButtonText,
        onConfirmed: onConfirmed,
      ),
    );
  }

  static Future<bool?>? toQpay({required QpayScreenModel model}) {
    return Get.to(() => const QpayScreen(), binding: QpayBinding(model: model));
  }

  static Future<String?> toPin() {
    return const PinCheckScreen().show();
  }

  static dynamic toForceUpdate({required ForceUpdateModel model}) {
    return ForceUpdateScreen(model: model).show();
  }
}
