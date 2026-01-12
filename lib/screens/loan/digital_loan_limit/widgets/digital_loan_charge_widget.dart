import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class LoanLimitChargePayWidget extends StatelessWidget {
  final String title;
  final double initialValue;
  final bool editable;
  final bool isLoading;
  final ValueChanged<double>? onChanged;
  final ValueChanged<PayType> onPay;

  LoanLimitChargePayWidget({
    super.key,
    required this.title,
    required this.initialValue,
    required this.editable,
    required this.isLoading,
    required this.onPay,
    this.onChanged,
  });

  final formatter = CurrencyTextInputFormatter.currency(
    symbol: '₮',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: isLoading
                ? const IOLoading()
                : Row(
                    children: [
                      Expanded(
                        child: IOButtonWidget(
                          onPressed: () => onPay(PayType.qpay),
                          model: IOButtonModel(
                            label: title,
                            type: IOButtonType.secondary,
                            size: IOButtonSize.small,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
