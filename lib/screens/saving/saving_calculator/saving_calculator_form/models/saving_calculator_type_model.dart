enum SavingCalculatorPeriodType {
  month(
    title: '1 жил',
    value: 12,
  ),
  year(
    title: '6 сар',
    value: 6,
  );

  const SavingCalculatorPeriodType({
    required this.title,
    required this.value,
  });

  final String title;
  final int value;
}

enum SavingCalculatorFrequencyType {
  annual(
    title: 'Жилийн эцэст',
    value: 'annual',
  ),
  semiAnnual(
    title: 'Хагас жилд',
    value: 'semi-annual',
  ),
  quarter(
    title: 'Улиралд',
    value: 'quarterly',
  );

  const SavingCalculatorFrequencyType({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
}
