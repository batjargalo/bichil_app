import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCreateCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanCreateCarController());
  }
}
