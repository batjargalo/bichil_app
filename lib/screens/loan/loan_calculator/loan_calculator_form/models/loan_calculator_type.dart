enum LoanCalculatorRepaymentType {
  fixed(title: 'Нийт төлөлт тэнцүү'),
  equalprincipal(title: 'Үндсэн төлөлт тэнцүү');

  const LoanCalculatorRepaymentType({
    required this.title,
  });

  final String title;
}
