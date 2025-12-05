import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class NewsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsPageController());
  }
}
