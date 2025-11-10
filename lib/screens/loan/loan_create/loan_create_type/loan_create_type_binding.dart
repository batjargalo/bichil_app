import 'package:bichil/screens/home/home.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class LoanCreateTypeBinding extends Bindings {
  final HomeProductModel model;
  LoanCreateTypeBinding({required this.model});

  @override
  void dependencies() {
    Get.lazyPut(() => LoanCreateTypeController(model: model));
  }
}
