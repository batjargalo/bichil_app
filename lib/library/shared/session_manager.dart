import 'dart:async';

import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';

class SessionManager {
  static final shared = SessionManager();

  final duration = const Duration(seconds: 5 * 60);
  Timer? timer;
  bool get isLogged {
    return HelperManager.isLogged;
  }

  Future getUser() async {
    final response = await UserApi().getUserInfo();
    if (response.isSuccess) {
      final user = UserModel.fromJson(response.data);
      await UserStoreManager.shared.write(kUser, user.toMap());
    }
  }

  Future logout() async {
    if (HelperManager.isSavedBiometricOnUser == false) {
      await BiometricManager.shared.deleteBiometric();
    }
    await UserStoreManager.shared.deleteStore();
    IOPages.toInitial();
  }

  Future eventChanged() async {
    timer?.cancel();
    if (isLogged) {
      timer = Timer(duration, () async {
        logout();
      });
    }
  }

  bool checkBankAccount() {
    if (HelperManager.user.hasBankAccount) {
      return true;
    } else {
      const LoanAccountDialog().show().then((result) {
        if (result == true) {
          MenuRoute.toChangeBank();
        }
      });

      return false;
    }
  }

  Future getAppVersion() async {
    final response = await InfoApi().getAppVersion();
    if (response.isSuccess) {
      final model = ForceUpdateModel.fromJson(response.data);

      if (model.updateType == 'none') return;

      AppRoute.toForceUpdate(model: model);
    }
  }
}
