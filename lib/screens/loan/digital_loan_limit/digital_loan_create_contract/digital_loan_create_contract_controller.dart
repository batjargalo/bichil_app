import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/digital_loan_limit/digital_loan_create_contract/digital_loan_create_contract_binding.dart';
import 'package:bichil/screens/loan/digital_loan_limit/digital_loan_signature/digital_loan_signature_binding.dart';
import 'package:bichil/screens/loan/digital_loan_limit/digital_loan_signature/digital_loan_signature_screen.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class DigitalLoanContractController extends IOController {
  final DigitalLoanLimitModel? item;
  final String? code;
  final html = ''.obs;

  DigitalLoanContractController({required this.item, required this.code});
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
    getData();
  }

  Future onTapNext() async {
    return Get.to(
      () => const DigitalLoanSignatureScreen(),
      binding: DigitalLoanSignatureBinding(),
    );
  }

  Future getData() async {
    isInitialLoading.value = true;
    late IOResponse response;
    if (code != null) {
      response = await LoanApi().getDigitalLoanContract();
    }
    isInitialLoading.value = false;

    if (response.isSuccess) {
      html.value = response.data['body'].stringValue;
    } else {
      Get.back();
      showError(text: response.message);
    }
  }
}
