import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class DigitalLoanCreateAmountBinding extends Bindings {
  final LoanLimitModel item;

  DigitalLoanCreateAmountBinding({required this.item});

  @override
  void dependencies() {
    Get.lazyPut(() => DigitalLoanCreateAmountController(item: item));
  }
}
