import 'package:bichil/library/library.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricResponse {
  final bool success;
  String errorMessage = '';

  BiometricResponse({
    required this.success,
    this.errorMessage = '',
  });
}

class BiometricManager {
  static final shared = BiometricManager();

  final auth = LocalAuthentication();

  bool get isAutenticated => HelperManager.isSavedBiometric;

  Future<List<BiometricType>> get availableBiometrics =>
      auth.getAvailableBiometrics();

  Future<bool> get isAvailable async {
    final types = await availableBiometrics;
    return types.contains(BiometricType.face) ||
        types.contains(BiometricType.fingerprint);
  }

  Future<String> get icon async {
    final types = await availableBiometrics;
    if (types.contains(BiometricType.face)) {
      return 'bio.face.svg';
    }
    return 'bio.finger.svg';
  }

  Future<BiometricResponse> checkAuthenticate() async {
    final value = await _authenticate();

    return value;
  }

  Future deleteBiometric() async {
    await DeviceStoreManager.shared.deleteKey(kBiometricWithLogin);
  }

  Future saveBiometric(BiometricModel data) async {
    await DeviceStoreManager.shared.write(kBiometricWithLogin, data.toMap());
    await UserStoreManager.shared.write(kBiometricWithUser, true);
  }

  Future<BiometricResponse> _authenticate() async {
    try {
      final didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      return BiometricResponse(
        success: didAuthenticate,
        errorMessage: 'Баталгаажуулалт амжилтгүй',
      );
    } on PlatformException catch (e) {
      final error = BiometricResponse(success: false);
      switch (e.code) {
        case auth_error.notAvailable:
          error.errorMessage = 'Баталгаажуулалт цуцлагдлаа';
          break;
        case auth_error.notEnrolled:
          error.errorMessage =
              'Баталгаажуулалт цуцлагдлаа. Та тохиргоогоо нээнэ үү';
          break;

        case auth_error.lockedOut:
          error.errorMessage =
              'Баталгаажуулалт цуцлагдлаа. Та олон удаа буруу оруулсан байна';
          break;

        default:
          error.errorMessage = 'Баталгаажуулахад алдаа гарлаа';
          break;
      }
      return error;
    }
  }
}
