import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class ChangeBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeBankController());
  }
}
