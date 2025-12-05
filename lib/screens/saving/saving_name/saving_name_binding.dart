import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingNameBinding extends Bindings {
  final SavingDetailModel saving;
  SavingNameBinding({required this.saving});

  @override
  void dependencies() {
    Get.lazyPut(
      () => SavingNameController(saving: saving),
    );
  }
}
