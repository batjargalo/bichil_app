import 'package:bichil/library/library.dart';
import 'package:get/get.dart';

class MenuLeftController extends IOController {
  void onTapBranch() {
    Get.back();
    MenuRoute.toBranch();
  }

  void onTapCall() {
    Get.back();
    MenuRoute.toContact();
  }

  void onTapFaq() {
    Get.back();
    MenuRoute.toFaq();
  }
}
