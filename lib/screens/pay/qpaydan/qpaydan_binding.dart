import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class QpayDanBinding extends Bindings {
  final QpayDanScreenModel model;
  final String danId;
  QpayDanBinding({required this.model, required this.danId});
  @override
  void dependencies() {
    Get.lazyPut(() => QpayDanController(model: model, danId: danId));
  }
}
