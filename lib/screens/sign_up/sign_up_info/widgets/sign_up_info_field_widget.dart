import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';

class SignUpInfoFieldWidget extends StatefulWidget {
  final SignUpInfoModel model;
  const SignUpInfoFieldWidget({super.key, required this.model});

  @override
  State<SignUpInfoFieldWidget> createState() => _SignUpInfoFieldWidgetState();
}

class _SignUpInfoFieldWidgetState extends State<SignUpInfoFieldWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.model.defaultValue.isNotEmpty) {
      setInitialData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.model.inputType) {
      SignUpInfoInputType.select => IODropdownWidget(
          model: widget.model.dropdown,
          pickItems: widget.model.fieldoptions
              .map(
                (e) => IODropdownSheetModel(
                  name: e.name,
                  value: e.value,
                ),
              )
              .toList(),
          onSelect: onSelect,
        ),
      SignUpInfoInputType.manual => IOTextfieldWidget(
          model: widget.model.field,
        ),
    };
  }

  void onSelect(IODropdownSheetModel<int> value) {
    widget.model.dropdown.setDropdownValue(value);
  }

  void setInitialData() {
    switch (widget.model.inputType) {
      case SignUpInfoInputType.select:
        final id = int.tryParse(widget.model.defaultValue) ?? 0;
        final name = widget.model.fieldoptions
            .firstWhere(
              (e) => e.id == id,
              orElse: () => SingUpInfoOptionModel.fromJson(JSON.nil),
            )
            .name;
        final value = IODropdownSheetModel(name: name, value: id);
        widget.model.dropdown.setDropdownValue(value);
        setState(() {});
        break;
      case SignUpInfoInputType.manual:
        widget.model.field.setData(widget.model.defaultValue);
        setState(() {});
        break;
    }
  }
}
