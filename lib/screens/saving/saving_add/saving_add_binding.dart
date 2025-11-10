import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingAddBinding extends Bindings {
  final String code;
  final double minimumAmount;

  SavingAddBinding({required this.code, required this.minimumAmount});

  @override
  void dependencies() {
    Get.lazyPut(() => SavingAddController(
          code: code,
          minimumAmount: minimumAmount,
        ));
  }
}
