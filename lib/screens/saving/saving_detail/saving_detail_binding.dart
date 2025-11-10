import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingDetailBinding extends Bindings {
  final SavingDetailModel model;
  SavingDetailBinding({required this.model});
  @override
  void dependencies() {
    Get.lazyPut(() => SavingDetailController(info: model));
  }
}
