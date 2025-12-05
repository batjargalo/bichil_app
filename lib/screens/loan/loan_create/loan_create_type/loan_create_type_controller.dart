import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanCreateTypeController extends IOController {
  final HomeProductModel model;
  final items = <LoanProductModel>[].obs;
  LoanCreateTypeController({required this.model});

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future getData() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getSubProducts(id: model.id);
    isInitialLoading.value = false;

    if (response.isSuccess) {
      items.value = response.data.listValue
          .map((e) => LoanProductModel.fromJson(e))
          .toList();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }

  void onTap(LoanProductModel item) {
    LoanRoute.toCreateForm(item: item);
  }
}
