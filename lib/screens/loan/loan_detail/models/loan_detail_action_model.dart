sealed class LoanDetailActionModel {
  final String title;
  String? value;

  LoanDetailActionModel({
    required this.title,
    this.value,
  });
}

class LoanDetailActionGetModel extends LoanDetailActionModel {
  LoanDetailActionGetModel({required super.title, super.value});
}

class LoanDetailActionCardModel extends LoanDetailActionModel {
  LoanDetailActionCardModel({required super.title, super.value});
}

class LoanDetailActionRepaymentModel extends LoanDetailActionModel {
  LoanDetailActionRepaymentModel({required super.title, super.value});
}

class LoanDetailActionCalculateModel extends LoanDetailActionModel {
  LoanDetailActionCalculateModel({required super.title, super.value});
}

class LoanDetailActionStatementModel extends LoanDetailActionModel {
  LoanDetailActionStatementModel({required super.title, super.value});
}

class LoanDetailActionPledgeModel extends LoanDetailActionModel {
  LoanDetailActionPledgeModel({required super.title, super.value});
}
