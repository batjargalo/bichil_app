import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class LoanTabScoringWidget extends StatelessWidget {
  final bool isSecure;
  final LoanInfoModel model;

  const LoanTabScoringWidget({
    super.key,
    required this.isSecure,
    required this.model,
  });

  void onTap() {
    // final result = SessionManager.shared.checkBankAccount();
    // if (result == false) return;
    LoanRoute.toRecreateAmount(item: model);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Зээлжих эрх',
                  style: IOStyles.body2Bold,
                ),
                Text(
                  isSecure ? '***********' : model.availComBal.toCurrency(),
                  style: IOStyles.h6.copyWith(
                    color: IOColors.brand500,
                  ),
                ),
              ],
            ),
          ),
          IOButtonWidget(
            onPressed: onTap,
            model: IOButtonModel(
              label: 'Зээл авах',
              type: IOButtonType.primary,
              size: IOButtonSize.small,
            ),
          ),
        ],
      ),
    );
  }
}
