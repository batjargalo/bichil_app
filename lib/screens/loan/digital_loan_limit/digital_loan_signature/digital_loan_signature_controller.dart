import 'package:bichil/library/library.dart';
import 'package:get/get.dart';

class DigitalLoanSignatureController extends IOController {
  final html = ''.obs;

  DigitalLoanSignatureController();
  // final saving = Get.arguments['saving'] as SavingDetailModel;
  // final create = Get.arguments['create'] as LoanCreateSavingModel;

  final isConfirmed = false.obs;

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    ever(isConfirmed, (value) {
      next.update((val) {
        val?.isEnabled = value;
      });
    });
  }

  Future onTapNext() async {}
}
