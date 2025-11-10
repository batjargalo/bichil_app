import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanStatementController extends IOController {
  final LoanInfoModel loan;
  final titleText = 'Зээлийн дансны хуулга';
  final items = <LoanStatementModel>[].obs;

  LoanStatementController({required this.loan});

  final startDate = DateTime.now().add(const Duration(days: -180)).obs;
  final endDate = DateTime.now().obs;

  final start = IODropdownModel<DateTime>(
    label: '',
    sheetTitle: 'Эхлэх огноо',
  );

  final end = IODropdownModel<DateTime>(
    label: '',
    sheetTitle: 'Дуусах огноо',
  );

  @override
  void onInit() {
    super.onInit();
    setInititalData();
  }

  void setInititalData() {
    start.setDropdownValue(
      IODropdownSheetModel(
        name: startDate.value.toFormattedString(format: 'yyyy-MM-dd'),
        value: startDate.value,
      ),
    );
    end.setDropdownValue(
      IODropdownSheetModel(
        name: endDate.value.toFormattedString(format: 'yyyy-MM-dd'),
        value: endDate.value,
      ),
    );
    getData();
  }

  void onTapStart() async {
    final result = await CalendarSheet(
      initial: startDate.value,
      start: DateTime.now().add(const Duration(days: -365)),
      end: DateTime.now(),
    ).show();
    Get.focusScope?.unfocus();
    if (result == null) return;
    startDate.value = result;
    setInititalData();
  }

  void onTapEnd() async {
    final result = await CalendarSheet(
      initial: endDate.value,
      start: DateTime.now().add(const Duration(days: -365)),
      end: DateTime.now(),
    ).show();
    Get.focusScope?.unfocus();
    if (result == null) return;
    endDate.value = result;
    setInititalData();
  }

  Future getData() async {
    items.clear();
    isInitialLoading.value = true;
    final response = await LoanApi().getLoanStatement(
      code: loan.acntCode,
      startDate: startDate.value.toFormattedString(format: 'yyyy-MM-dd'),
      endDate: endDate.value.toFormattedString(format: 'yyyy-MM-dd'),
    );
    isInitialLoading.value = false;

    if (response.isSuccess) {
      items.value = response.data['txns'].listValue
          .map((e) => LoanStatementModel.fromJson(e))
          .toList();
    } else {
      showError(text: response.message);
    }
  }
}
