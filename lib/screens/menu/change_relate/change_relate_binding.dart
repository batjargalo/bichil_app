import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class ChangeRelateBinding extends Bindings {
  final UserRelatedModel person;
  ChangeRelateBinding({required this.person});
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeRelateController(person: person));
  }
}
