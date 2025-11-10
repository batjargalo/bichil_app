import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCreateSavingPageBinding extends Bindings {
  final SavingDetailModel saving;

  LoanCreateSavingPageBinding({
    required this.saving,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => LoanCreateSavingPageController(saving: saving),
    );
    Get.lazyPut(() => LoanCreateSavingConditionController());
    Get.lazyPut(() => LoanCreateSavingConfirmController());
  }
}
