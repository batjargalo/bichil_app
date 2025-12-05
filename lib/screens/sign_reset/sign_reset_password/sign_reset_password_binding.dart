import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignResetPasswordBinding extends Bindings {
  final SignResetModel model;

  SignResetPasswordBinding({
    required this.model,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => SignResetPasswordController(model: model),
    );
  }
}
