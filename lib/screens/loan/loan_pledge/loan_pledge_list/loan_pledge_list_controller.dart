import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanPledgeListController extends IOController {
  final items = Get.arguments['items'] as List<LoanPledgeModel>;

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  Future getInfo() async {
    final response = await LoanApi().getPledgeInfo(
      code: items.first.acntCode,
      sysNo: items.first.sysNo,
    );
  }
}
