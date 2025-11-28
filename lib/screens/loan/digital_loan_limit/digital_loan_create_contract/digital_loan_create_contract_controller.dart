import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class DigitalLoanContractController extends IOController {
  final DigitalLoanLimitModel? item;
  final String? code;
  final html = ''.obs;
  DigitalLoanContractController({required this.item, required this.code});
  // final saving = Get.arguments['saving'] as SavingDetailModel;
  // final create = Get.arguments['create'] as LoanCreateSavingModel;

  final accepted = false.obs;
  int? contractId;

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    ever(accepted, (e) {
      next.update((val) {
        val?.isEnabled = e;
      });
    });
    getData();
  }

  Future onTapNext() async {
    return Get.to(
      () => const DigitalLoanSignatureScreen(isLoading: false),
      binding: DigitalLoanSignatureBinding(),
      arguments: {'contractId': contractId},
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
      contractId = response.data['contract_id'].integer;
    } else {
      Get.back();
      showError(text: response.message);
    }
  }
}
