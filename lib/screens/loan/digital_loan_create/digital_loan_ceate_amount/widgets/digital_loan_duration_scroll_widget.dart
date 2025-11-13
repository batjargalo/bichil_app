import 'digital_loan_duration_scroll_widget/digital_loan_duration_scroll_tile.dart';
import 'package:flutter/material.dart';

class LoanDurationWidget extends StatefulWidget {
  final ValueChanged<int> onChanged;

  const LoanDurationWidget({super.key, required this.onChanged});

  @override
  State<LoanDurationWidget> createState() => _LoanDurationWidgetSate();
}

class _LoanDurationWidgetSate extends State<LoanDurationWidget> {
  static const List<String> durations = [
    '7 хоног',
    '14 хоног',
    '21 хоног',
    '1 сар',
    '3 сар',
    '6 сар',
    '9 сар',
    '1 жил',
  ];

  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        onSelectedItemChanged: (value) => widget.onChanged(value.toInt()),
        itemExtent: 45,
        perspective: 0.005,
        diameterRatio: 1.5,
        physics: FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 8,
          builder: (context, index) {
            return LoanDurationWidgetTile(duration: durations[index]);
          },
        ),
      ),
    );
  }
}
