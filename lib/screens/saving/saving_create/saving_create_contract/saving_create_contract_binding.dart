import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCreateContractBinding extends Bindings {
  final SavingCreateContractType type;
  final SavingCreateModel? item;
  final String? code;
  SavingCreateContractBinding({
    required this.type,
    required this.item,
    required this.code,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => SavingCreateContractController(type: type, item: item, code: code),
    );
  }
}
