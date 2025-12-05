import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCreatePoliticBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingCreatePoliticController());
  }
}
