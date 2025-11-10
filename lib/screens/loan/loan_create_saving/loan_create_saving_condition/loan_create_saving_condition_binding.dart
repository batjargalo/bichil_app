import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class LoanCreateSavingConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanCreateSavingConditionController());
  }
}
