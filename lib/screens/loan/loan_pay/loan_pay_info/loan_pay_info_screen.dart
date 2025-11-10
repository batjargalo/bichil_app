import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/loan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanPayInfoScreen extends GetView<LoanPayInfoController> {
  const LoanPayInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _payments,
                  ),
                ),
              ),
      ),
    );
  }

  List<Widget> get _payments {
    final scheduled = Obx(() => LoanPayInfoWidget(
          editable: false,
          isLoading: controller.scheduleLoading.value,
          title: 'Хуваарийн дагуу төлөх дүн',
          initialValue: controller.loan.nextSchdTotal,
          onPay: (type) => controller.onPay(LoanPayType.schedule, type),
        ));
    final custom = Obx(() => LoanPayInfoWidget(
          editable: true,
          title: 'Өөр дүнгээр төлөх',
          isLoading: controller.customLoading.value,
          initialValue: controller.customAmount.value,
          onChanged: controller.customAmount.call,
          onPay: (type) => controller.onPay(LoanPayType.custom, type),
        ));
    final close = Obx(
      () => controller.checkedClose.value
          ? LoanPayInfoWidget(
              editable: false,
              title: 'Зээл хаах дүн',
              isLoading: controller.closeLoading.value,
              initialValue: controller.closeAmount.value,
              onPay: (type) => controller.onPay(LoanPayType.close, type),
            )
          : IOButtonWidget(
              model: controller.checkClose.value,
              onPressed: controller.getCloseAmount,
            ),
    );

    final closeLine = Obx(
      () => controller.checkedClose.value
          ? LoanPayInfoWidget(
              editable: false,
              title: 'Зээл хаах дүн',
              isLoading: controller.closeLoading.value,
              initialValue: controller.closeAmount.value,
              onPay: (type) => controller.onPay(LoanPayType.closeLine, type),
            )
          : IOButtonWidget(
              model: controller.checkClose.value,
              onPressed: controller.getCloseAmount,
            ),
    );

    if (controller.loan.canTakeLoan) {
      return [
        scheduled,
        const SizedBox(height: 16),
        custom,
        const SizedBox(height: 16),
        closeLine,
        const SizedBox(height: 16),
      ];
    } else if (controller.isExpired) {
      return [close];
    } else {
      return [
        scheduled,
        const SizedBox(height: 16),
        custom,
        const SizedBox(height: 16),
        close,
        const SizedBox(height: 16),
      ];
    }
  }
}
