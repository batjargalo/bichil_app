import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanHistoryDetailBinding extends Bindings {
  final String code;

  LoanHistoryDetailBinding({required this.code});

  @override
  void dependencies() {
    Get.lazyPut(() => LoanHistoryDetailController(code: code));
  }
}
