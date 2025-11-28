import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class LoanPledgeListController extends IOController {
  LoanPledgeListController()
    : items = (Get.arguments['items'] as List<LoanPledgeModel>? ?? [])
          .whereType<LoanPledgeModel>()
          .toList();

  final List<LoanPledgeModel> items;

  late final List<LoanPledgeUiModel> uiItems = items
      .map(_mapToUiModel)
      .toList(growable: false);

  LoanPledgeUiModel _mapToUiModel(LoanPledgeModel item) {
    final registerNo = _valueOrDash(item.registerNo);
    final date = _valueOrDash(_formatDate(item.date));
    final description = _valueOrDash(item.description);

    final parsedName = item.name.trim();
    final segments = parsedName
        .split('/')
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty)
        .toList(growable: false);

    final rawHeaderCode = segments.isNotEmpty ? segments.first : parsedName;
    final headerCode = _formatHeaderCode(rawHeaderCode);
    final assetNameSegments = segments.length > 1 ? segments.sublist(1) : [];
    final assetName = assetNameSegments.join(' / ');
    final collateralName = _valueOrDash(
      assetName.isNotEmpty ? assetName : parsedName,
    );

    final fields = <LoanPledgeUiField>[
      LoanPledgeUiField(label: 'Барьцаа хөрөнгийн нэр', value: collateralName),
      LoanPledgeUiField(label: 'Бүртгэлийн дугаар', value: registerNo),
      LoanPledgeUiField(label: 'Барьцаа хөрөнгийн огноо', value: date),
      if (item.tax.isNotEmpty)
        LoanPledgeUiField(label: 'Татвар', value: item.tax),
      if (item.penalty.isNotEmpty)
        LoanPledgeUiField(label: 'Торгууль', value: item.penalty),
    ];
    if (description != '-') {
      fields.add(LoanPledgeUiField(label: 'Өнгө/мкв', value: description));
    }

    return LoanPledgeUiModel(
      headerCode: _valueOrDash(headerCode),
      headerLabel: 'Сер дугаар',
      fields: fields,
    );
  }

  String _valueOrDash(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? '-' : trimmed;
  }

  String _formatHeaderCode(String value) {
    final sanitized = value.trim();
    if (sanitized.isEmpty) {
      return sanitized;
    }

    final digitBuffer = StringBuffer();
    final charBuffer = StringBuffer();

    for (final rune in sanitized.runes) {
      final character = String.fromCharCode(rune);
      if (_isDigit(character)) {
        digitBuffer.write(character);
      } else {
        charBuffer.write(character);
      }
    }

    final digits = digitBuffer.toString();
    final chars = charBuffer.toString().trim();

    if (digits.isEmpty || chars.isEmpty) {
      return sanitized;
    }

    return '$digits $chars';
  }

  bool _isDigit(String character) {
    if (character.length != 1) {
      return false;
    }

    final codeUnit = character.codeUnitAt(0);
    return codeUnit >= 48 && codeUnit <= 57;
  }

  String _formatDate(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return trimmed;
    }

    final segments = trimmed
        .split('/')
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty)
        .toList(growable: false);

    if (segments.length == 2) {
      return '${segments.first} / ${segments.last}';
    }

    return trimmed;
  }
}
