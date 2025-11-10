import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class PinChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinChangeController());
  }
}
