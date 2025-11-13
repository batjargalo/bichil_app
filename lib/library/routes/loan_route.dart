import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanRoute {
  static toProductList() {
    return Get.to(() => const LoanProductsScreen(), binding: LoanProductsBinding());
  }

  static toCreateType({required HomeProductModel model}) {
    return Get.to(() => const LoanCreateTypeScreen(), binding: LoanCreateTypeBinding(model: model));
  }

  static toCreateForm({required LoanProductModel item}) {
    return Get.to(() => const LoanCreateFormScreen(), binding: LoanCreateFormBinding(item: item));
  }

  static toCreateSavingAmount({required SavingDetailModel saving}) {
    return Get.to(
      () => const LoanCreateSavingConditionScreen(),
      binding: LoanCreateSavingConditionBinding(),
      arguments: saving,
    );
  }

  static toCreateSavingConfirm({required SavingDetailModel saving, required LoanCreateSavingModel create}) {
    return Get.to(
      () => const LoanCreateSavingConfirmScreen(),
      binding: LoanCreateSavingConfirmBinding(),
      arguments: {'saving': saving, 'create': create},
    );
  }

  static toCreateCar() {
    return Get.to(() => const LoanCreateCarScreen(), binding: LoanCreateCarBinding());
  }

  static toCreatePhone() {
    return Get.to(() => const LoanCreatePhoneScreen(), binding: LoanCreatePhoneBinding());
  }

  static toCreateProperty() {
    return Get.to(() => const LoanCreatePropertyScreen(), binding: LoanCreatePropertyBinding());
  }

  static Future? toRecreateAmount({required LoanInfoModel item}) {
    return Get.to(() => const LoanRecreateAmountScreen(), binding: LoanRecreateAmountBinding(item: item));
  }

  static Future? toCreateAmount({required LoanLimitModel item}) {
    return Get.to(() => const DigitalLoanCreateAmountScreen(), binding: DigitalLoanCreateAmountBinding(item: item));
  }

  static toDetail({required LoanInfoModel loan}) {
    return Get.to(() => const LoanDetailScreen(), binding: LoanDetailBinding(loan: loan));
  }

  static toStatement({required LoanInfoModel loan}) {
    return Get.to(() => const LoanStatementScreen(), binding: LoanStatementBinding(loan: loan));
  }

  static toSchedule({required LoanInfoModel loan}) {
    return Get.to(() => const LoanScheduleScreen(), binding: LoanScheduleBinding(loan: loan));
  }

  static toPayInfo({required LoanInfoModel loan}) {
    return Get.to(() => const LoanPayInfoScreen(), binding: LoanPayInfoBinding(loan: loan));
  }

  static toDigitaLoanLimit() {
    return Get.to(() => const DigitalLoanLimitScreen(), binding: DigitalLoanLimitBinding());
  }

  static toCalculatorForm({LoanInfoModel? loan, bool hasAppBar = true}) {
    return Get.to(
      () => const LoanCalculatorFormScreen(),
      binding: LoanCalculatorFormBinding(loan: loan, hasAppBar: hasAppBar),
    );
  }

  static toCalculatorResult({required LoanCalculatorModel model}) {
    return Get.to(() => const LoanCalculatorResultScreen(), binding: LoanCalculatorResultBinding(model: model));
  }

  static Future? toHistoryList() {
    return Get.to(() => const LoanHistoryListScreen(), binding: LoanHistoryListBinding());
  }

  static Future? toHistoryDetail({required String code}) {
    return Get.to(() => const LoanHistoryDetailScreen(), binding: LoanHistoryDetailBinding(code: code));
  }

  static Future? toPledgeList({required List items}) {
    return Get.to(() => const LoanPledgeListScreen(), binding: LoanPledgeListBinding(), arguments: {'items': items});
  }
}
