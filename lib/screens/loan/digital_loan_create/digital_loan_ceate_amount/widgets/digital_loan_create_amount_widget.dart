import 'package:bichil/library/library.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class DigitalLoanCreateAmountWidget extends StatefulWidget {
  final double maxValue;
  // final double currentValue;
  final ValueChanged<double> onChanged;

  const DigitalLoanCreateAmountWidget({
    super.key,
    required this.maxValue,
    // required this.currentValue,
    required this.onChanged,
  });

  @override
  State<DigitalLoanCreateAmountWidget> createState() => _DigitalLoanCreateAmountWidgetState();
}

class _DigitalLoanCreateAmountWidgetState extends State<DigitalLoanCreateAmountWidget> {
  final step = 10000.0;

  final formatter = CurrencyTextInputFormatter.currency(symbol: '', decimalDigits: 0);
  final textController = TextEditingController();

  double value = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChangeSlider(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox.square(
              dimension: 48,
              child: FilledButton(
                onPressed: onDecrement,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: IOColors.brand50,
                  foregroundColor: IOColors.brand500,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Icon(Icons.remove, color: IOColors.textPrimary),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: IOColors.backgroundPrimary, borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: IOStyles.h6.copyWith(color: IOColors.brand500),
                  cursorColor: IOColors.brand500,
                  cursorHeight: 20,
                  controller: textController,
                  decoration: InputDecoration(border: InputBorder.none),
                  inputFormatters: [formatter],
                  onChanged: (_) {
                    final value = formatter.getUnformattedValue();
                    onChange(value.toDouble());
                  },
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox.square(
              dimension: 48,
              child: FilledButton(
                onPressed: onIncrement,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: IOColors.brand50,
                  foregroundColor: IOColors.brand500,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Icon(Icons.add, color: IOColors.textPrimary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SliderTheme(
          data: const SliderThemeData(
            padding: EdgeInsets.zero,
            activeTrackColor: IOColors.brand300,
            inactiveTrackColor: IOColors.strokePrimary,
            thumbColor: IOColors.brand500,
            overlayColor: IOColors.brand200,
            trackHeight: 6,
            inactiveTickMarkColor: Colors.transparent,
            activeTickMarkColor: Colors.transparent,
          ),
          child: Slider(
            min: 0,
            max: widget.maxValue,
            value: value.clamp(0, widget.maxValue),
            divisions: (widget.maxValue / step).floor(),
            onChanged: (value) {
              final roundedValue = (value / step).round() * step;
              final tempValue = roundedValue.clamp(0, widget.maxValue).toDouble();
              onChangeSlider(tempValue);
            },
          ),
        ),
      ],
    );
  }

  void onDecrement() {
    double tempValue = 0.0;
    if (value > step) {
      tempValue = value - step;
    }

    onChangeSlider(tempValue);
  }

  void onIncrement() {
    double tempValue = value + step;
    if (tempValue > widget.maxValue) {
      tempValue = value;
    }

    onChangeSlider(tempValue);
  }

  void onChangeSlider(double val) {
    textController.text = formatter.formatDouble(val);
    onChange(val);
  }

  void onChange(double val) {
    setState(() {
      value = val;
    });

    widget.onChanged(val);
  }
}
