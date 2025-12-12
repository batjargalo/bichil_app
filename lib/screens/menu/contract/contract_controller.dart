import 'package:bichil/library/library.dart';
import 'package:get/get.dart';

class ContractController extends IOController {
  final accepted = false.obs;
  int? contractId;
  final html = ''.obs;
  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    // ever(accepted, (e) {
    //       next.update((val) {
    //         val?.isEnabled = e;
    //       });
    //     });
    getData();
  }

  Future onTapNext() async {
    LoanRoute.toDigitalLoanSignature(contractId: contractId);
  }

  Future getData() async {
    isInitialLoading.value = true;
    late IOResponse response;
    response = await LoanApi().getDigitalSignedContract();

    // response = await LoanApi().getDigitalLoanContract();

    isInitialLoading.value = false;

    if (response.isSuccess) {
      html.value = response.data['body'].stringValue;
      contractId = response.data['id'].integer;
    } else {
      Get.back();
      showError(text: response.message);
    }
  }
}
