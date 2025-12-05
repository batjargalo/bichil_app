import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingHistoryDetailBinding extends Bindings {
  final String code;
  SavingHistoryDetailBinding({required this.code});

  @override
  void dependencies() {
    Get.lazyPut(
      () => SavingHistoryDetailController(code: code),
    );
  }
}
