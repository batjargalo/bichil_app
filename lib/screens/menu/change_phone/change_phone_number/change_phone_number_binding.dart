import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class ChangePhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePhoneNumberController());
  }
}
