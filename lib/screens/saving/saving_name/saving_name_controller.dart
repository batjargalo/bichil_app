import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingNameController extends IOController {
  final SavingDetailModel saving;

  final name = IOTextfieldModel(
    label: 'Шинэ нэр',
    validators: [ValidatorType.notEmpty],
    autofocus: true,
  );

  final button = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  SavingNameController({required this.saving});

  @override
  void onInit() {
    super.onInit();
    name.status.addListener(() {
      button.update((val) {
        val?.isEnabled = name.isValid;
      });
    });
    name.setData(saving.accountName);
  }

  Future changeName() async {
    Get.focusScope?.unfocus();
    isLoading.value = true;
    button.update((val) {
      val?.isLoading = true;
    });

    final response = await SavingApi().changeSavingName(
      code: saving.id,
      name: name.value,
    );

    isLoading.value = false;
    button.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
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
