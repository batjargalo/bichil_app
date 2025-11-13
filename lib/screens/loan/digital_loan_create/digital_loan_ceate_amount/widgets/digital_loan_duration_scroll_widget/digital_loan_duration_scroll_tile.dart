import 'package:flutter/material.dart';

class LoanDurationWidgetTile extends StatelessWidget {
  const LoanDurationWidgetTile({super.key, required this.duration});

  final String duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        key: key,
        child: Center(
          child: Text(duration, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
