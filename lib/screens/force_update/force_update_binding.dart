import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class ForceUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForceUpdateController());
  }
}
