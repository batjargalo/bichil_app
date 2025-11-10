import 'package:bichil/library/library.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badge_control/flutter_app_badge_control.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class MainController extends IOController {
  final pushData = JSON.nil.obs;

  @override
  void onInit() {
    super.onInit();
    getToken();
    setNotificationCount();
    SessionManager.shared.getAppVersion();
  }

  Future getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    Log.error(fcmToken ?? '', 'FCM');
    await DeviceStoreManager.shared.write(kFcmToken, fcmToken ?? 'NOTOKEN');
  }

  Future setNotificationCount() async {
    await FlutterAppBadgeControl.removeBadge();
  }

  void onEventChanged() {
    SessionManager.shared.eventChanged();
  }
}
