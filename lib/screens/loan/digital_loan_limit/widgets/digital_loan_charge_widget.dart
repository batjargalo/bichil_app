import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class LoanPayInfoWidget extends StatelessWidget {
  final String title;
  final double initialValue;
  final bool editable;
  final bool isLoading;
  final ValueChanged<double>? onChanged;
  final ValueChanged<PayType> onPay;

  LoanPayInfoWidget({
    super.key,
    required this.title,
    required this.initialValue,
    required this.editable,
    required this.isLoading,
    required this.onPay,
    this.onChanged,
  });

  final formatter = CurrencyTextInputFormatter.currency(symbol: '₮', decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(title, style: IOStyles.body2Regular.copyWith(color: IOColors.textSecondary)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              enabled: editable,
              initialValue: formatter.formatDouble(initialValue),
              cursorColor: IOColors.brand500,
              style: IOStyles.h6.copyWith(color: IOColors.brand500),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: InputBorder.none),
              inputFormatters: [formatter],
              onChanged: (value) {
                onChanged?.call(formatter.getUnformattedValue().toDouble());
              },
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 40,
              child: isLoading
                  ? const IOLoading()
                  : Row(
                      children: [
                        Expanded(
                          child: IOButtonWidget(
                            onPressed: () => onPay(PayType.qpay),
                            model: IOButtonModel(
                              label: 'Qpay-р төлөх',
                              type: IOButtonType.secondary,
                              size: IOButtonSize.small,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
