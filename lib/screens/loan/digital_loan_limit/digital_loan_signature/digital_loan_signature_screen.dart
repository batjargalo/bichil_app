import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/digital_loan_limit/digital_loan_signature/digital_loan_signature_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';

class DigitalLoanSignatureScreen
    extends GetView<DigitalLoanSignatureController> {
  final bool isLoading;

  const DigitalLoanSignatureScreen({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        appBar: IOAppBar(titleText: 'Зээлийн гэрээ'),
        body: Column(
          children: [
            controller.isInitialLoading.value
                ? const Expanded(child: IOLoading())
                : Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: controller.pageIndex,
                      builder: (context, index, child) => IndexedStack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              spacing: 24.0,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        constraints: BoxConstraints.expand(),
                                        color: Colors.white,
                                        child: HandSignature(
                                          control: controller.control,
                                          drawer: ShapeSignatureDrawer(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          backgroundColor: IOColors.backgroundPrimary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: IOButtonWidget(
                      model: controller.clearSig.value,
                      onPressed: controller.onTapClear,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: IOButtonWidget(
                      model: controller.sentSig.value,
                      onPressed: controller.onTapSend,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
