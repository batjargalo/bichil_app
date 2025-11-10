import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCreatePropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanCreatePropertyController());
  }
}
