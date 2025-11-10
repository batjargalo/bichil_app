import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCloseInfoController extends IOController {
  final SavingCloseModel model;

  final isChecked = false.obs;

  final button = IOButtonModel(
    label: 'Дуусгах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  SavingCloseInfoController({required this.model});

  @override
  void onInit() {
    super.onInit();
    ever(isChecked, (value) {
      button.update((val) {
        val?.isEnabled = value;
      });
    });
    getData();
  }

  void getData() async {
    isInitialLoading.value = true;

    final purpose = switch (model.type) {
      SavingCloseType.deposite => 'withdraw_partial',
      SavingCloseType.close => 'withdraw_fully',
    };

    final response = await SavingApi().getCalculateRate(
      amount: model.closeAmount,
      purpose: purpose,
      account: model.saving.accountNumber,
    );

    if (response.isSuccess) {
      model.yieldToBe = response.data['yield_to_be'].ddoubleValue;
      model.yieldCurrent = response.data['yield_current'].ddoubleValue;
      model.interestToBe = response.data['interest_to_be'].ddoubleValue;
      model.interestCurrent = response.data['interest_current'].ddoubleValue;
      model.balanceToBe = response.data['balance_to_be'].ddoubleValue;
      isInitialLoading.value = false;
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  Future closeSaving() async {
    final pin = await AppRoute.toPin();
    if (pin == null) return;
    isLoading.value = true;
    button.update((val) {
      val?.isLoading = true;
    });

    final response = await switch (model.type) {
      SavingCloseType.deposite => SavingApi().withdrawSaving(
          amount: model.closeAmount,
          code: model.saving.accountNumber,
          bankId: 0,
          accountNumber: '',
          accountName: '',
          pin: pin,
        ),
      SavingCloseType.close => SavingApi().closeSaving(
          amount: model.closeAmount,
          code: model.saving.accountNumber,
          bankId: 0,
          accountNumber: '',
          accountName: '',
          pin: pin,
        ),
    };

    isLoading.value = false;
    button.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      await AppRoute.toSuccess(
        title: 'Амжилттай',
        description: response.message,
      );
      Get.back();
      Get.back();
      if (Get.isRegistered<SavingTabController>()) {
        Get.find<SavingTabController>().onRefresh();
      }
      if (Get.isRegistered<SavingDetailController>()) {
        Get.find<SavingDetailController>().getInfo();
      }
    } else {
      showError(text: response.message);
    }
  }
}
