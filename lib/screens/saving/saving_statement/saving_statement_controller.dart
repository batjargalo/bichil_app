import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SavingStatementController extends IOController {
  final String code;
  SavingStatementController({required this.code});

  final titleText = 'Хуулга';
  final inItems = <SavingStatementModel>[].obs;
  final outItems = <SavingStatementModel>[].obs;
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
    inItems.clear();
    outItems.clear();
    isInitialLoading.value = true;
    final response = await SavingApi().getSavingStatement(
      code: code,
      startDate: startDate.value.toFormattedString(format: 'yyyy-MM-dd'),
      endDate: endDate.value.toFormattedString(format: 'yyyy-MM-dd'),
    );
    isInitialLoading.value = false;

    if (response.isSuccess) {
      for (final json in response.data['txns'].listValue) {
        final item = SavingStatementModel.fromJson(json);
        item.txnCode == 'DR' ? inItems.add(item) : outItems.add(item);
      }
    } else {
      Get.back();
      showError(text: response.message);
    }
  }
}
