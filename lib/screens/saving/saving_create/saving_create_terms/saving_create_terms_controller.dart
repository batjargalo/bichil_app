import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingCreateTermsController extends IOController {
  final create = Get.arguments as SavingCreateModel;

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  final accepted = false.obs;

  bool get hasSubscription => create.hasSubscribe;
  SavingCreateContractType get contract => hasSubscription
      ? SavingCreateContractType.trusted
      : SavingCreateContractType.saving;

  @override
  void onInit() {
    super.onInit();
    ever(accepted, (e) {
      next.update((val) {
        val?.isEnabled = e;
      });
    });
  }

  void onTapTerms() {
    MenuRoute.toTerms();
  }

  void onTapContract() {
    SavingRoute.toCreateContract(type: contract, item: create, code: null);
  }

  Future onTapNext() async {
    SavingRoute.toCreatePolitic(create);
  }
}
