import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingRoute {
  static toCreateCondition() {
    return Get.to(
      () => const SavingCreateConditionScreen(),
      binding: SavingCreateConditionBinding(),
    );
  }

  static toCreateConfirm(SavingCreateModel item) {
    return Get.to(
      () => const SavingCreateConfirmScreen(),
      binding: SavingCreateConfirmBinding(),
      arguments: item,
    );
  }

  static toCreateTerms(SavingCreateModel item) {
    return Get.to(
      () => const SavingCreateTermsScreen(),
      binding: SavingCreateTermsBinding(),
      arguments: item,
    );
  }

  static Future? toCreateContract(
      {required SavingCreateContractType type,
      required SavingCreateModel? item,
      required String? code}) {
    return Get.to(
      () => const SavingCreateContractScreen(),
      binding: SavingCreateContractBinding(type: type, item: item, code: code),
    );
  }

  static toCreatePolitic(SavingCreateModel item) {
    return Get.to(
      () => const SavingCreatePoliticScreen(),
      binding: SavingCreatePoliticBinding(),
      arguments: item,
    );
  }

  static toDetail({required SavingDetailModel saving}) {
    return Get.to(
      () => const SavingDetailScreen(),
      binding: SavingDetailBinding(model: saving),
    );
  }

  static toStatement({required String code}) {
    return Get.to(
      () => const SavingStatementScreen(),
      binding: SavingStatementBinding(code: code),
    );
  }

  static toChangeName({required SavingDetailModel saving}) {
    return Get.to(
      () => const SavingNameScreen(),
      binding: SavingNameBinding(saving: saving),
    );
  }

  static toAddBalance({required String code, required double minimumAmount}) {
    return Get.to(
      () => const SavingAddScreen(),
      binding: SavingAddBinding(code: code, minimumAmount: minimumAmount),
    );
  }

  static toCalculatorForm({required bool hasAppBar}) {
    return Get.to(
      () => const SavingCalculatorFormScreen(),
      binding: SavingCalculatorFormBinding(hasAppBar: hasAppBar),
    );
  }

  static toCalculatorResult({required SavingCalculatorModel model}) {
    return Get.to(
      () => const SavingCalculatorResultScreen(),
      binding: SavingCalculatorResultBinding(model: model),
    );
  }

  static toHistoryList() {
    return Get.to(
      () => const SavingHistoryListScreen(),
      binding: SavingHistoryListBinding(),
    );
  }

  static toHistoryDetail({required String code}) {
    return Get.to(
      () => const SavingHistoryDetailScreen(),
      binding: SavingHistoryDetailBinding(code: code),
    );
  }

  static toDeposite({required SavingCloseModel model}) {
    return Get.to(
      () => const SavingCloseAmountScreen(),
      binding: SavingCloseAmountBinding(model: model),
    );
  }

  static toCloseConfirm({required SavingCloseModel model}) {
    return Get.to(
      () => const SavingCloseInfoScreen(),
      binding: SavingCloseInfoBinding(model: model),
    );
  }
}
