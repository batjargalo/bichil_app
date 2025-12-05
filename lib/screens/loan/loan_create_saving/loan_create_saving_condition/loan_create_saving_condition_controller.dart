import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCreateSavingConditionController extends IOController {
  final saving = Get.arguments as SavingDetailModel;
  final create = LoanCreateSavingModel();
  final amount = 0.0.obs;

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    ever(amount, (_) => checkValidation());
    fetchData();
  }

  Future fetchData() async {
    isInitialLoading.value = true;
    final response = await LoanApi().getLoanSavingRate(
      code: saving.accountNumber,
    );

    if (response.isSuccess) {
      create.rate = response.data['rateMonth'].ddoubleValue;
      create.maxAmount = response.data['maxAmount'].ddoubleValue;
      create.maxTerm = response.data['maxTerm'].integerValue;
      isInitialLoading.value = false;
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  void checkValidation() {
    next.update((val) {
      val?.isEnabled = amount.value > 0;
    });
  }

  void onTapNext() {
    final amountVal = amount.value;
    if (amountVal > create.maxAmount) {
      showWarning(
        text: 'Зээлийн дүн хэтэрсэн байна. Та бага утга оруулна уу',
        acceptText: 'Тийм',
      );
      return;
    }
    create.amount = amountVal;
    LoanRoute.toCreateSavingConfirm(
      saving: saving,
      create: create,
    );
  }
}
