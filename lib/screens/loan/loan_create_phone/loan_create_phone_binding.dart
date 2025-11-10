import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCreatePhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanCreatePhoneController());
  }
}
