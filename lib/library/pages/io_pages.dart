import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';
import 'package:bichil/library/library.dart';

class IOPages {
  static String get initial =>
      //  HelperManager.isLogged
      //     ? TabBarScreen.routeName
      HelperManager.isSavedBiometric ? SignInBioScreen.routeName : SignInUserScreen.routeName;

  static final pages = [
    GetPage(name: SignInUserScreen.routeName, page: () => const SignInUserScreen(), binding: SignInUserBinding()),
    GetPage(name: SignInBioScreen.routeName, page: () => const SignInBioScreen(), binding: SignInBioBinding()),
    GetPage(name: TabBarScreen.routeName, page: () => const TabBarScreen(), binding: TabBarBinding()),
  ];

  static void toInitial() {
    Get.offAllNamed(initial);
  }

  static void toHome() {
    Get.offAllNamed(TabBarScreen.routeName);
  }
}
