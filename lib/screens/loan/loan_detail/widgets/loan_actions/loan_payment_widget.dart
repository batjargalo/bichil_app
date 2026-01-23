import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';
import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';

class LoanPayment extends GetView<LoanDetailController> {
  const LoanPayment({super.key});

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
                          'Өөр дүнгээр төлөх',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: IOStyles.h3.copyWith(color: IOColors.brand500),
                          cursorColor: IOColors.brand500,
                          cursorHeight: 20,
                          controller: controller.textController,
                          decoration: InputDecoration(border: InputBorder.none),
                          inputFormatters: [controller.formatter],
                          onChanged: (_) {
                            final value = controller.formatter
                                .getUnformattedValue();
                            controller.onChangePayment(value.toDouble());
                          },
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
                  controller.onCustomsLoan();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IOColors.brand600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Төлөх',
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
