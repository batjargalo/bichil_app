import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanScheduleWidget extends GetView<LoanDetailController> {
  const LoanScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.schedule.isEmpty) return const SizedBox.shrink();
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
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Төлөх өдөр',
                                          style: item.isPaid
                                              ? TextStyle(
                                                  fontFamily:
                                                      IOFonts.gilroyRegular,
                                                  fontSize: 12,
                                                  color:
                                                      IOColors.successPrimary,
                                                )
                                              : IOStyles.caption1Regular,
                                        ),
                                        Text(
                                          item.schdDate.toFormattedString(
                                            hasLocalTimeZone: false,
                                            format: 'yyyy/MM/dd',
                                          ),
                                          style: item.isPaid
                                              ? TextStyle(
                                                  fontFamily:
                                                      IOFonts.gilroyRegular,
                                                  fontSize: 12,
                                                  color:
                                                      IOColors.successPrimary,
                                                )
                                              : IOStyles.caption1Bold,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Төлөх дүн',
                                          style: item.isPaid
                                              ? TextStyle(
                                                  fontFamily:
                                                      IOFonts.gilroyRegular,
                                                  fontSize: 12,
                                                  color:
                                                      IOColors.successPrimary,
                                                )
                                              : IOStyles.caption1Regular,
                                        ),
                                        Text(
                                          item.totalAmount.toCurrency(),
                                          style: item.isPaid
                                              ? TextStyle(
                                                  fontFamily:
                                                      IOFonts.gilroyRegular,
                                                  fontSize: 12,
                                                  color:
                                                      IOColors.successPrimary,
                                                )
                                              : IOStyles.caption1Bold,
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed:
                                          !item.isPaid &&
                                              controller.checkIsTodayPayment(
                                                item.schdDate,
                                              )
                                          ? () => controller.onScheduleLoan(
                                              item.totalAmount,
                                            )
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: IOColors.brand600,
                                        disabledBackgroundColor: item.isPaid
                                            ? IOColors.successPrimary
                                            : Colors.grey.shade300,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        item.isPaid
                                            ? 'Төлсөн'
                                            : controller.checkIsTodayPayment(
                                                item.schdDate,
                                              )
                                            ? 'Төлөх'
                                            : "Төлөөгүй",
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
        ],
      ),
    );
  }
}
