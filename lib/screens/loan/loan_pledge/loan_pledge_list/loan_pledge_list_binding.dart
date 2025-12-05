import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class LoanPledgeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanPledgeListController());
  }
}
