import 'package:bichil/screens/home/home.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class LoanHomeBinding extends Bindings {
  final HomeProductModel model;
  LoanHomeBinding({required this.model});

  @override
  void dependencies() {
    Get.lazyPut(() => LoanHomeController());
  }
}
