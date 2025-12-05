class LoanPledgeUiModel {
  LoanPledgeUiModel({
    required this.headerCode,
    required this.headerLabel,
    required this.fields,
  });

  final String headerCode;
  final String headerLabel;
  final List<LoanPledgeUiField> fields;
}

class LoanPledgeUiField {
  const LoanPledgeUiField({required this.label, required this.value});

  final String label;
  final String value;
}
