import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class ContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContractController());
  }
}
