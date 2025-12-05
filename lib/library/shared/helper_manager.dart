import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:bichil/library/library.dart';

// Define the missing constants
const String kSecureSaving = 'secure_saving';
const String kSecureLoan = 'secure_loan';

class HelperManager {
  static bool get isWalkthroughShowed =>
      DeviceStoreManager.shared.data<bool>(kWalkthroughShowed) ?? false;
  static bool get isLogged => UserStoreManager.shared.hasData(kToken);

  static bool get isSavedBiometric =>
      DeviceStoreManager.shared.hasData(kBiometricWithLogin);

  static bool get isSavedBiometricOnUser =>
      UserStoreManager.shared.data<bool>(kBiometricWithUser) ?? false;

  static bool get isSecureLoan =>
      UserStoreManager.shared.data<bool>(kSecureLoan) ?? true;

  static bool get isSecureSaving =>
      UserStoreManager.shared.data<bool>(kSecureSaving) ?? true;

  static TokenModel get token {
    final json = UserStoreManager.shared.jsonData(kToken);
    return TokenModel.fromJson(json);
  }

  static String get fcmToken {
    return DeviceStoreManager.shared.data<String>(kFcmToken) ?? 'NOTOKEN';
  }

  static UserModel get user {
    final json = UserStoreManager.shared.jsonData(kUser);
    return UserModel.fromJson(json);
  }

  static BiometricModel get biometric {
    final json = DeviceStoreManager.shared.jsonData(kBiometricWithLogin);
    return BiometricModel.fromJson(json);
  }

  static int get notifCount {
    return UserStoreManager.shared.data<int>(kNotificationCount) ?? 0;
  }

  static String get os {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      _ => '',
    };
  }

  static Future<String> get deviceModel async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => (await deviceInfoPlugin.androidInfo).device,
      TargetPlatform.iOS => (await deviceInfoPlugin.iosInfo).model,
      _ => '',
    };
  }

  static Future<String> get deviceId async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => (await deviceInfoPlugin.androidInfo).id,
      TargetPlatform.iOS =>
        (await deviceInfoPlugin.iosInfo).identifierForVendor ?? 'EMPTYID',
      _ => '',
    };
  }

  static Future<String> get version async {
    final v = await appVersion;
    return 'Хувилбар $v';
  }

  static Future<String> get appVersion async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String build = packageInfo.buildNumber;
    return '$version-$build';
  }

  static Future<String> get buildVersion async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
