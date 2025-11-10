import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCreateConfirmController extends IOController {
  final create = Get.arguments as SavingCreateModel;

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: true,
  ).obs;

  Future onTapNext() async {
    SavingRoute.toCreateTerms(create);
  }
}
