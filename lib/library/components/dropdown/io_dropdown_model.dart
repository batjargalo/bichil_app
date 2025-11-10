import 'package:bichil/library/library.dart';

class IODropdownModel<T> extends IOTextfieldModel {
  @override
  bool get readOnly => true;

  T? get dropdownValue => dropdownItem?.value;

  final String sheetTitle;
  final String icon;
  IODropdownSheetModel<T>? dropdownItem;

  IODropdownModel({
    required super.label,
    required this.sheetTitle,
    this.icon = 'chevron.down.svg',
    super.isEnabled,
    super.validators,
    super.hasBorder,
  });

  void setDropdownValue(IODropdownSheetModel<T>? item) {
    dropdownItem = item;
    setData(item?.name ?? '');
    if (item == null) {
      controller.clear();
    }
  }
}
