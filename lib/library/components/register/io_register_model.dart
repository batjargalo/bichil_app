import 'package:flutter/material.dart';
import 'package:bichil/library/library.dart';

class IORegisterModel {
  final first = IOTextfieldModel(
    label: '',
    readOnly: true,
    validators: [ValidatorType.notEmpty],
  );
  final last = IOTextfieldModel(
    label: '',
    readOnly: true,
    validators: [ValidatorType.notEmpty],
  );
  final number = IOTextfieldModel(
    label: 'Регистрийн дугаар',
    maxLength: 8,
    keyboardType: TextInputType.number,
    validators: [ValidatorType.registerNumber],
  );

  final status = ValueNotifier(IOTextfieldStatusModel());

  String get value => first.value + last.value + number.value;
  bool get isValid => status.value.isValid;

  final chars = [
    'А',
    'Б',
    'В',
    'Г',
    'Д',
    'Е',
    'Ё',
    'Ж',
    'З',
    'И',
    'Й',
    'К',
    'Л',
    'М',
    'Н',
    'О',
    'Ө',
    'П',
    'Р',
    'С',
    'Т',
    'У',
    'Ү',
    'Ф',
    'Х',
    'Ц',
    'Ч',
    'Ш',
    'Щ',
    'Ъ',
    'Ы',
    'Ь',
    'Э',
    'Ю',
    'Я',
  ];
}
