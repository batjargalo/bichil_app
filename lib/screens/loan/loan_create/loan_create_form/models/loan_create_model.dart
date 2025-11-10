class LoanCreateModel {
  final int product;
  final String firstNme;
  final String lastName;
  final String phone;
  final String email;
  final String proofValue;
  final int nearBranch;

  LoanCreateModel({
    required this.product,
    required this.firstNme,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.proofValue,
    required this.nearBranch,
  });

  Map<String, dynamic> toMap() => {
        'product': product,
        'first_name': firstNme,
        'last_name': lastName,
        'phone': phone,
        'email': email,
        'proof_value': proofValue,
        'near_branch': nearBranch,
      };
}
