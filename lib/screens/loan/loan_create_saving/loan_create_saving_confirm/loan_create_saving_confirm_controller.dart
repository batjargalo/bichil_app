import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCreateSavingConfirmController extends IOController {
  final saving = Get.arguments['saving'] as SavingDetailModel;
  final create = Get.arguments['create'] as LoanCreateSavingModel;

  final isConfirmed = false.obs;
  final contract = SavingCreateContractType.loan;

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

  void onTapTerms() {
    MenuRoute.toTerms();
  }

  void onTapContract() {
    SavingRoute.toCreateContract(
      type: contract,
      code: saving.accountNumber,
      item: null,
    );
  }

  Future onTapNext() async {
    final pin = await AppRoute.toPin();
    if (pin == null) return;

    isLoading.value = true;
    next.update((val) {
      val?.isLoading = true;
    });

    final model = LoanRecreateModel(
      amount: create.amount,
      accountNo: saving.accountNumber,
      pinCode: pin,
      term: 0,
      payDay: 0,
    );
    final response = await LoanApi().createFromSaving(model: model);

    isLoading.value = false;
    next.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      await AppRoute.toSuccess(
        title: 'Амжилттай',
        description: response.message,
        buttonText: 'Дуусгах',
      );
      Get.until((route) => route.isFirst);
      if (Get.isRegistered<LoanTabController>()) {
        Get.find<LoanTabController>().onRefresh();
      }
      if (Get.isRegistered<SavingTabController>()) {
        Get.find<SavingTabController>().onRefresh();
      }
    } else {
      showError(text: response.message);
    }
  }
}
