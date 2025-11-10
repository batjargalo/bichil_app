import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class QpayBinding extends Bindings {
  final QpayScreenModel model;
  QpayBinding({required this.model});
  @override
  void dependencies() {
    Get.lazyPut(() => QpayController(model: model));
  }
}
