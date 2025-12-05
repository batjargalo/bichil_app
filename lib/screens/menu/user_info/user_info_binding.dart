import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class UserInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoController());
  }
}
