import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class FaqController extends IOController {
  final loanItems = <FaqModel>[].obs;
  final appItems = <FaqModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future getData() async {
    final response = await InfoApi().getFaq();

    if (response.isSuccess) {
      final temp =
          response.data.listValue.map((e) => FaqModel.fromJson(e)).toList();
      appItems.value = temp.where((e) => e.qaType == 'app').toList();
      loanItems.value = temp.where((e) => e.qaType == 'loan').toList();
    }
  }
}
