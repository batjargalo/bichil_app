import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingStatementBinding extends Bindings {
  final String code;
  SavingStatementBinding({required this.code});

  @override
  void dependencies() {
    Get.lazyPut(() => SavingStatementController(code: code));
  }
}
