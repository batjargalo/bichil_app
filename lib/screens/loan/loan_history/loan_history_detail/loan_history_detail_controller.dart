import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan_tab/loan_tab.dart';
import 'package:get/get.dart';

class LoanHistoryDetailController extends IOController {
  final String code;
  final info = Rx<LoanInfoModel?>(null);
  final errorMessage = ''.obs;

  LoanHistoryDetailController({required this.code});

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  Future getInfo() async {
    isInitialLoading.value = true;

    final response = await LoanApi().getLoanInfo(code: code);

    isInitialLoading.value = false;

    if (response.isSuccess) {
      info.value = LoanInfoModel.fromJson(response.data);
    } else {
      errorMessage.value = response.message;
    }
  }
}
