import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class UserDeleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserDeleteController());
  }
}
