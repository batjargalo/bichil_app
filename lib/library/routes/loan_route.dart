import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';
import 'package:g_json/g_json.dart';

class LoanRoute {
  static Future<dynamic>? toProductList() {
    return Get.to(
      () => const LoanProductsScreen(),
      binding: LoanProductsBinding(),
    );
  }

  static Future<dynamic>? toCreateType({required HomeProductModel model}) {
    return Get.to(
      () => const LoanCreateTypeScreen(),
      binding: LoanCreateTypeBinding(model: model),
    );
  }

  static Future<dynamic>? toCreateForm({required LoanProductModel item}) {
    return Get.to(
      () => const LoanCreateFormScreen(),
      binding: LoanCreateFormBinding(item: item),
    );
  }

  static Future<dynamic>? toCreateSavingAmount({
    required SavingDetailModel saving,
  }) {
    return Get.to(
      () => const LoanCreateSavingConditionScreen(),
      binding: LoanCreateSavingConditionBinding(),
      arguments: saving,
    );
  }

  static Future<dynamic>? toCreateSavingConfirm({
    required SavingDetailModel saving,
    required LoanCreateSavingModel create,
  }) {
    return Get.to(
      () => const LoanCreateSavingConfirmScreen(),
      binding: LoanCreateSavingConfirmBinding(),
      arguments: {'saving': saving, 'create': create},
    );
  }

  static Future<dynamic>? toCreateCar() {
    return Get.to(
      () => const LoanCreateCarScreen(),
      binding: LoanCreateCarBinding(),
    );
  }

  static Future<dynamic>? toCreatePhone() {
    return Get.to(
      () => const LoanCreatePhoneScreen(),
      binding: LoanCreatePhoneBinding(),
    );
  }

  static Future<dynamic>? toCreateProperty() {
    return Get.to(
      () => const LoanCreatePropertyScreen(),
      binding: LoanCreatePropertyBinding(),
    );
  }

  static Future? toRecreateAmount({required LoanInfoModel item}) {
    return Get.to(
      () => const LoanRecreateAmountScreen(),
      binding: LoanRecreateAmountBinding(item: item),
    );
  }

  static Future? toCreateAmount({required LoanLimitModel item}) {
    return Get.to(
      () => const DigitalLoanCreateAmountScreen(),
      binding: DigitalLoanCreateAmountBinding(item: item),
    );
  }

  static Future<dynamic>? toDetail({required LoanInfoModel loan}) {
    return Get.to(
      () => const LoanDetailScreen(),
      binding: LoanDetailBinding(loan: loan),
    );
  }

  static Future<dynamic>? toStatement({required LoanInfoModel loan}) {
    return Get.to(
      () => const LoanStatementScreen(),
      binding: LoanStatementBinding(loan: loan),
    );
  }

  static Future<dynamic>? toSchedule({required LoanInfoModel loan}) {
    return Get.to(
      () => const LoanScheduleScreen(),
      binding: LoanScheduleBinding(loan: loan),
    );
  }

  static Future<dynamic>? toPayInfo({required LoanInfoModel loan}) {
    return Get.to(
      () => const LoanPayInfoScreen(),
      binding: LoanPayInfoBinding(loan: loan),
    );
  }

  static Future<dynamic>? toDigitaLoanLimit() {
    return Get.to(
      () => const DigitalLoanLimitScreen(),
      binding: DigitalLoanLimitBinding(),
    );
  }

  static Future<dynamic>? toCalculatorForm({
    LoanInfoModel? loan,
    bool hasAppBar = true,
  }) {
    return Get.to(
      () => const LoanCalculatorFormScreen(),
      binding: LoanCalculatorFormBinding(loan: loan, hasAppBar: hasAppBar),
    );
  }

  static Future<dynamic>? toCalculatorResult({
    required LoanCalculatorModel model,
  }) {
    return Get.to(
      () => const LoanCalculatorResultScreen(),
      binding: LoanCalculatorResultBinding(model: model),
    );
  }

  static Future? toHistoryList() {
    return Get.to(
      () => const LoanHistoryListScreen(),
      binding: LoanHistoryListBinding(),
    );
  }

  static Future? toHistoryDetail({required String code}) {
    return Get.to(
      () => const LoanHistoryDetailScreen(),
      binding: LoanHistoryDetailBinding(code: code),
    );
  }

  static Future? toPledgeList({required List items}) {
    return Get.to(
      () => const LoanPledgeListScreen(),
      binding: LoanPledgeListBinding(),
      arguments: {'items': items},
    );
  }

  static Future<JSON?>? toCustomerInfoDan() {
    return Get.to(
      () => const DigitalLoanLimitDanScreen(),
      binding: DigitalLoanLimitDanBinding(),
    );
  }

  static Future<JSON?>? toDigitalLoanContract() {
    return Get.to(
      () => const DigitalLoanContractScreen(),
      binding: DigitalLoanContractBinding(item: null, code: ''),
    );
  }

  static Future<JSON?>? toDigitalLoanSignature({int? contractId}) {
    return Get.to(
      () => const DigitalLoanSignatureScreen(isLoading: false),
      binding: DigitalLoanSignatureBinding(),
      arguments: {'contractId': contractId},
    );
  }
}
