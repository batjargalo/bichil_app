import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanScheduleController extends IOController {
  final LoanInfoModel loan;
  final titleText = 'Эргэн төлөлтийн хуваарь';
  final items = <LoanScheduleModel>[].obs;

  LoanScheduleController({required this.loan});

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future getData() async {
    isInitialLoading.value = true;
    final response = await LoanApi().getLoanSchedule(
      code: loan.acntCode,
    );
    isInitialLoading.value = false;

    if (response.isSuccess) {
      items.value = response.data.listValue
          .map((e) => LoanScheduleModel.fromJson(e))
          .toList();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }
}
