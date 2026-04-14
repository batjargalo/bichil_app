import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCreateSavingConditionController extends IOController {
  final saving = (Get.arguments as List<SavingDetailModel>).obs;
  final create = <LoanCreateSavingModel>[].obs;
  final amount = 0.0.obs;

  // Track the currently displayed card index
  final activeIndex = 0.obs;

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isInitialLoading.value = true;
    create.addAll(List.generate(saving.length, (_) => LoanCreateSavingModel()));
    ever(amount, (_) => checkValidation());
    for (var i = 0; i < saving.length; i++) {
      await fetchData(i);
    }
  }

  Future fetchData(int index) async {
    final response = await LoanApi().getLoanSavingRateList(code: saving[index].accountNumber);

    if (response.isSuccess) {
      create[index].rate = response.data['rateMonth'].ddoubleValue;
      create[index].maxAmount = response.data['maxAmount'].ddoubleValue;
      create[index].maxTerm = response.data['maxTerm'].integerValue;

      if (response.data['maxAmount'].ddoubleValue == 0) {
        create[index].message = response.data['message'].stringValue;
      }

      if (index == saving.length - 1) {
        isInitialLoading.value = false;
      }
    }
  }

  void onPageChanged(int index) {
    activeIndex.value = index;
    checkValidation();
  }

  void checkValidation() {
    next.update((val) {
      val?.isEnabled = amount.value >= 20000 && amount.value <= create[activeIndex.value].maxAmount;
    });
  }

  void onTapNext() {
    final currentIdx = activeIndex.value;
    final amountVal = amount.value;

    if (amountVal > create[currentIdx].maxAmount) {
      showWarning(text: 'Зээлийн дүн хэтэрсэн байна. Та бага утга оруулна уу', acceptText: 'Тийм');
      return;
    }

    create[currentIdx].amount = amountVal;
    LoanRoute.toCreateSavingConfirm(saving: saving[currentIdx], create: create[currentIdx]);
  }
}
