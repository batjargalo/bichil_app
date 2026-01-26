import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanDetailScreen extends GetView<LoanDetailController> {
  const LoanDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: 'Зээлийн дэлгэрэнгүй'),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          // bottom: 16 + Get.mediaQuery.padding.bottom,
        ),
        child: Obx(
          () => Column(
            children: [
              LoanDetail(loan: controller.loan),
              const SizedBox(height: 16),
              LoanIcon(
                loan: controller.loan,
                action: controller.onIconTapped,
                activeIconIndex: controller.selectedIndex.value,
              ),
              const SizedBox(height: 16),
              controller.isInitialLoading.value
                  ? const IOLoading()
                  : switch (controller.selectedIndex.value) {
                      0 => LoanScheduleWidget(key: key),
                      1 => LoanClose(
                        closeAmount: controller.closeAmount.toDouble(),
                        // action: controller.onIconTapped,
                        // activeIconIndex: controller.selectedIndex.value,
                      ),
                      2 => LoanExtension(
                        totalExtensionAmount: controller.totalExtensionAmount,
                        allIntBal: controller.allIntBal,
                        billFineBal: controller.billFineBal,
                        princBal: controller.princBal,
                        onExtensionLoan: controller.onExtensionLoan,
                        // totalExtensionAmount: controller.totalExtensionAmount(),
                        // action: controller.onIconTapped,
                        // activeIconIndex: controller.selectedIndex.value,
                      ),
                      3 => LoanPayment(key: key),
                      _ => const SizedBox.shrink(),
                    },

              // LoanDetailListWidget(
              //   actions: controller.actions,
              //   onTap: controller.onTapAction,
              // ),
              // if (controller.isLoading.isTrue)
              //   const Padding(
              //     padding: EdgeInsets.only(top: 16),
              //     child: IOLoading(),
              //   )
              // else if (controller.pledgeList.isNotEmpty)
              //   Padding(
              //     padding: const EdgeInsets.only(top: 16),
              //     child: LoanDetailListWidget(
              //       actions: controller.pledge,
              //       onTap: controller.onTapAction,
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
