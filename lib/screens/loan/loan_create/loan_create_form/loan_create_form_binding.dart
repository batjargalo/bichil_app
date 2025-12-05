import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCreateFormBinding extends Bindings {
  final LoanProductModel item;
  LoanCreateFormBinding({required this.item});

  @override
  void dependencies() {
    Get.lazyPut(() => LoanCreateFormController(item: item));
  }
}
