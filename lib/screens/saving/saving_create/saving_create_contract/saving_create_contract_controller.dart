import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCreateContractController extends IOController {
  final SavingCreateContractType type;
  final SavingCreateModel? item;
  final String? code;
  final html = ''.obs;

  SavingCreateContractController({
    required this.type,
    required this.item,
    required this.code,
  });

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future getData() async {
    isInitialLoading.value = true;
    late IOResponse response;
    if (item != null) {
      response = await SavingApi().getSavingContract(model: item!);
    }
    if (code != null) {
      response = await SavingApi().getSavingContractInfo(code: code!);
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

enum SavingCreateContractType {
  saving(title: 'Итгэлцлийн гэрээ'),
  trusted(title: 'Итгэлцлийн гэрээ'),
  loan(title: 'Зээлийн гэрээ');

  const SavingCreateContractType({required this.title});

  final String title;
}
