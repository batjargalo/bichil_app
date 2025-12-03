import 'digital_loan_duration_scroll_widget/digital_loan_duration_scroll_tile.dart';
import 'package:flutter/material.dart';

class LoanDurationWidget extends StatefulWidget {
  final ValueChanged<int> onChanged;

  final dynamic amount;

  const LoanDurationWidget({
    super.key,
    required this.onChanged,
    required this.amount,
  });

  @override
  State<LoanDurationWidget> createState() => _LoanDurationWidgetSate();
}

class _LoanDurationWidgetSate extends State<LoanDurationWidget> {
  static const List<String> duration1 = [
    '7 хоног',
    '14 хоног',
    '21 хоног',
    '1 сар',
  ];

  static const List<String> duration2 = [
    '7 хоног',
    '14 хоног',
    '21 хоног',
    '1 сар',
    '3 сар',
  ];
  static const List<String> duration3 = [
    '7 хоног',
    '14 хоног',
    '21 хоног',
    '1 сар',
    '3 сар',
    '6 сар',
  ];
  static const List<String> duration4 = [
    '7 хоног',
    '14 хоног',
    '21 хоног',
    '1 сар',
    '3 сар',
    '6 сар',
    '9 сар',
  ];
  static const List<String> duration5 = [
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
          childCount: widget.amount <= 500000
              ? duration1.length
              : widget.amount <= 1500000
              ? duration2.length
              : widget.amount <= 2500000
              ? duration3.length
              : widget.amount <= 3500000
              ? duration4.length
              : widget.amount <= 5000000
              ? duration5.length
              : 0,
          builder: (context, index) {
            switch (widget.amount) {
              case <= 500000:
                if (index >= duration1.length) return null;
                return LoanDurationWidgetTile(duration: duration1[index]);
              case <= 1500000:
                if (index >= duration2.length) return null;
                return LoanDurationWidgetTile(duration: duration2[index]);
              case <= 2500000:
                if (index >= duration3.length) return null;
                return LoanDurationWidgetTile(duration: duration3[index]);
              case <= 3500000:
                if (index >= duration4.length) return null;
                return LoanDurationWidgetTile(duration: duration4[index]);
              case <= 5000000:
                if (index >= duration5.length) return null;
                return LoanDurationWidgetTile(duration: duration5[index]);
              default:
                return null;
            }
            // return LoanDurationWidgetTile(duration: durations[index]);
          },
        ),
      ),
    );
  }
}
