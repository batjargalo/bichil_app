import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignResetOtpBinding extends Bindings {
  final SignResetModel model;

  SignResetOtpBinding({
    required this.model,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => SignResetOtpController(model: model),
    );
  }
}
