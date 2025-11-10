import 'package:bichil/screens/loan/loan.dart';
import 'package:get/get.dart';

class LoanRecreateAmountBinding extends Bindings {
  final LoanInfoModel item;

  LoanRecreateAmountBinding({required this.item});

  @override
  void dependencies() {
    Get.lazyPut(() => LoanRecreateAmountController(item: item));
  }
}
