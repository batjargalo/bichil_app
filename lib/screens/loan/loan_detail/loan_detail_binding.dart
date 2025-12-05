import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanDetailBinding extends Bindings {
  final LoanInfoModel loan;
  LoanDetailBinding({required this.loan});

  @override
  void dependencies() {
    Get.lazyPut(
      () => LoanDetailController(loan: loan),
    );
  }
}
