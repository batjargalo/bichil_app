import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bichil/screens/screens.dart';

class LoanClose extends GetView<LoanDetailController> {
  final double closeAmount;
  const LoanClose({super.key, required this.closeAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [
                        const Text(
                          'Зээл хаах дүн',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          closeAmount.toCurrency(),
                          style: IOStyles.h3.copyWith(color: IOColors.brand500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  controller.onCloseLoan();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IOColors.brand600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Зээл хаах',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
