import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SavingHistoryDetailScreen extends GetView<SavingHistoryDetailController> {
  const SavingHistoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Итгэлцлийн дэлгэрэнгүй',
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : controller.info.value == null
                ? IOEmptyWidget(
                    text: controller.errorMessage.value,
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SavingHistoryDetailWidget(
                          model: controller.info.value!,
                        ),
                        const SizedBox(height: 16),
                        IOCardBorderWidget(
                          child: IOGesture(
                            onTap: controller.onTapStatement,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Хуулга харах',
                                    style: IOStyles.body2Semibold,
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/chevron.right.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
