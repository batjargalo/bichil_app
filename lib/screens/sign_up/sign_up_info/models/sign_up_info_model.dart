import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';

class SignUpInfoModel {
  final int id;
  final List<SingUpInfoOptionModel> fieldoptions;
  final String name;
  final String paramKey;
  final String infoKey;
  final String coreKey;
  final SignUpInfoDataType dataType;
  final SignUpInfoInputType inputType;
  final bool isEmpty;
  final bool isRequired;
  final String defaultValue;

  SignUpInfoModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        paramKey = json['param_key'].stringValue,
        infoKey = json['info_key'].stringValue,
        coreKey = json['core_key'].stringValue,
        dataType = switch (json['data_type'].stringValue) {
          'text' => SignUpInfoDataType.text,
          'number' => SignUpInfoDataType.number,
          'email' => SignUpInfoDataType.email,
          _ => SignUpInfoDataType.text,
        },
        inputType = switch (json['input_type'].stringValue) {
          'select' => SignUpInfoInputType.select,
          _ => SignUpInfoInputType.manual,
        },
        isEmpty = json['is_empty'].booleanValue,
        isRequired = json['is_required'].booleanValue,
        defaultValue = json['value'].stringValue,
        fieldoptions = json['fieldoptions']
            .listValue
            .map((e) => SingUpInfoOptionModel.fromJson(e))
            .toList();

  late final field = IOTextfieldModel(
    label: name,
    validators: [ValidatorType.notEmpty],
    keyboardType: switch (dataType) {
      SignUpInfoDataType.number => TextInputType.number,
      SignUpInfoDataType.text => TextInputType.text,
      SignUpInfoDataType.email => TextInputType.emailAddress,
    },
  );
  late final dropdown = IODropdownModel<int>(
    label: name,
    sheetTitle: name,
  );

  bool get isValid => switch (inputType) {
        SignUpInfoInputType.select => dropdown.isValid,
        SignUpInfoInputType.manual => field.isValid,
      };

  dynamic get value {
    switch (inputType) {
      case SignUpInfoInputType.select:
        return dropdown.dropdownValue;
      case SignUpInfoInputType.manual:
        final v = field.value;
        switch (dataType) {
          case SignUpInfoDataType.number:
            return int.tryParse(v) ?? 0;
          case SignUpInfoDataType.text:
            return v;
          case SignUpInfoDataType.email:
            return v;
        }
    }
  }
}

class SingUpInfoOptionModel {
  final int id;
  final int value;
  final String name;
  final int orderNumber;

  final int field;

  SingUpInfoOptionModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        value = json['value'].integerValue,
        name = json['name'].stringValue,
        orderNumber = json['order_number'].integerValue,
        field = json['field'].integerValue;
}

enum SignUpInfoDataType { number, text, email }

enum SignUpInfoInputType { select, manual }
