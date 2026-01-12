import 'digital_loan_duration_scroll_widget/digital_loan_duration_scroll_tile.dart';
import 'package:flutter/material.dart';

class LoanDurationWidget extends StatefulWidget {
  final ValueChanged<int> onChanged;
  final ValueChanged<int> setDuration;
  final dynamic amount;
  final List<Map<String, dynamic>> durations;
  const LoanDurationWidget({
    super.key,
    required this.onChanged,
    required this.setDuration,
    required this.amount,
    required this.durations,
  });

  @override
  State<LoanDurationWidget> createState() => _LoanDurationWidgetSate();
}

class _LoanDurationWidgetSate extends State<LoanDurationWidget> {
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
        onSelectedItemChanged: (value) {
          widget.onChanged(value.toInt());
          widget.setDuration(value.toInt());
        },
        itemExtent: 45,
        perspective: 0.005,
        diameterRatio: 1.5,
        physics: FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: widget.durations.length,
          builder: (context, index) {
            bool isSelected = index == _controller.selectedItem;
            return LoanDurationWidgetTile(
              duration: widget.durations[index]["label"],
              isSelected: isSelected,
            );
          },
        ),
      ),
    );
  }
}
