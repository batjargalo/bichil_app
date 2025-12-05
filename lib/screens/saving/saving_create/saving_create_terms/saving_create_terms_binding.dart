import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCreateTermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingCreateTermsController());
  }
}
