import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingHistoryDetailController extends IOController {
  final String code;
  final info = Rx<SavingDetailModel?>(null);
  final errorMessage = ''.obs;

  SavingHistoryDetailController({required this.code});

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  Future getInfo() async {
    isInitialLoading.value = true;

    final response = await SavingApi().getSavingInfo(code: code);

    isInitialLoading.value = false;

    if (response.isSuccess) {
      info.value = SavingDetailModel.fromHistoryJson(response.data);
    } else {
      errorMessage.value = response.message;
    }
  }

  void onTapStatement() {
    if (info.value == null) return;
    SavingRoute.toStatement(code: info.value!.accountNumber);
  }
}
