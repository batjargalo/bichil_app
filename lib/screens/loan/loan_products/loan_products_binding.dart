import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanProductsController());
  }
}
