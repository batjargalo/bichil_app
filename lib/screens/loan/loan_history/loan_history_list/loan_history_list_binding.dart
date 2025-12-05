import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class LoanHistoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanHistoryListController());
  }
}
