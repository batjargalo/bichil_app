import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';

class IOAmountField extends StatelessWidget {
  final String text;
  final ValueChanged<double> onChanged;

  const IOAmountField({
    super.key,
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: IOStyles.h1.copyWith(
                    color: IOColors.brand500,
                  ),
                ),
                Container(
                  height: 1,
                  color: IOColors.brand500,
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Opacity(
            opacity: 0,
            child: TextFormField(
              autocorrect: false,
              autofocus: true,
              style: IOStyles.h1.copyWith(
                color: IOColors.brand500,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => onChanged(double.tryParse(value) ?? 0),
            ),
          ),
        ),
      ],
    );
  }
}
