import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class BranchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BranchController());
    Get.lazyPut(() => BranchListController());
    Get.lazyPut(() => BranchMapController());
  }
}
