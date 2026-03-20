import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanScheduleWidget extends GetView<LoanDetailController> {
  const LoanScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.schedule.isEmpty) return const SizedBox.shrink();

    final DateTime? nextSchdDate = DateTime.tryParse(
      controller.loan.nextSchdDate,
    );

    final bool isFutureDate =
        nextSchdDate == null || nextSchdDate.isAfter(DateTime.now());

    return Container(
      height: Get.height * 0.42,
      clipBehavior: Clip.hardEdge,
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Column(
                        children: [
                          const Text(
                            'Эргэн төлөлтийн хуваарь',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.schedule.length,
                            itemBuilder: (context, index) {
                              final item = controller.schedule[index];

                              final TextStyle currentLabelStyle = item.isPaid
                                  ? TextStyle(
                                      fontFamily: IOFonts.gilroyRegular,
                                      fontSize: 12,
                                      color: IOColors.successPrimary,
                                    )
                                  : IOStyles.caption1Regular;

                              final TextStyle currentValueStyle = item.isPaid
                                  ? TextStyle(
                                      fontFamily: IOFonts.gilroyRegular,
                                      fontSize: 12,
                                      color: IOColors.successPrimary,
                                    )
                                  : IOStyles.caption1Bold;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Төлөх өдөр',
                                          style: currentLabelStyle,
                                        ),
                                        Text(
                                          item.schdDate.toFormattedString(
                                            hasLocalTimeZone: false,
                                            format: 'yyyy/MM/dd',
                                          ),
                                          style: currentValueStyle,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Төлөх дүн',
                                          style: currentLabelStyle,
                                        ),
                                        Text(
                                          item.totalAmount.toCurrency(),
                                          style: currentValueStyle,
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: null,
                                      style: ElevatedButton.styleFrom(
                                        disabledBackgroundColor: item.isPaid
                                            ? IOColors.successPrimary
                                            : Colors.grey.shade300,
                                        shape: const StadiumBorder(),
                                      ),
                                      child: Text(
                                        item.isPaid ? 'Төлсөн' : "Төлөөгүй",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                Text(
                  controller.loan.nextSchdTotal.toCurrency(),
                  style: IOStyles.h6.copyWith(color: IOColors.brand500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: isFutureDate
                    ? null
                    : () {
                        if (controller.loan.nextSchdTotal ==
                            controller.closeAmount.value) {
                          controller.onCloseLoan(false);
                        } else {
                          controller.onScheduleLoan(
                            controller.loan.nextSchdTotal,
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IOColors.brand600,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Төлөлт хийх',
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
