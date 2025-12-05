import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCalculatorFormBinding extends Bindings {
  final LoanInfoModel? loan;
  final bool hasAppBar;

  LoanCalculatorFormBinding({this.loan, required this.hasAppBar});
  @override
  void dependencies() {
    Get.lazyPut(() => LoanCalculatorFormController(
          loan: loan,
          hasAppBar: hasAppBar,
        ));
  }
}
