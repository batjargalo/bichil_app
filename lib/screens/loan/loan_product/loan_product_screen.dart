import 'package:bichil/library/components/button/io_button_model.dart';
import 'package:bichil/library/components/button/io_button_widget.dart';
import 'package:bichil/library/components/main/io_card_border.dart';
import 'package:bichil/library/components/main/io_loading.dart';
import 'package:bichil/library/components/main/io_refresher.dart';
import 'package:bichil/library/theme/io_colors.dart';
import 'package:bichil/library/theme/io_styles.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoanProductScreen extends GetView<LoanProductController> {
  const LoanProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isInitialLoading.value
          ? const IOLoading()
          : IORefresher(
              controller: controller.refresher,
              onRefresh: controller.onRefresh,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: IOCardBorderWidget(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Барьцаагүй зээл", style: IOStyles.body2Bold),
                            const Spacer(),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/clock.svg',
                                  width: 12,
                                  height: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "7 хоног ~ 12 сар",
                                  style: IOStyles.caption2Bold.copyWith(
                                    color: IOColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              'Боломжит хэмжээ',
                              style: IOStyles.caption1Regular.copyWith(
                                color: IOColors.brand500,
                              ),
                            ),
                            Text(
                              '${controller.loanLimit.first.loanLimit ?? 0} ₮ хүртэл',
                              style: IOStyles.body2Semibold.copyWith(
                                color: IOColors.textSecondary,
                              ),
                            ),
                            const Spacer(),
                            controller.loanLimit.first.limitCalcButton == true
                                ? IOButtonWidget(
                                    onPressed: () {},
                                    model: IOButtonModel(
                                      label: 'Зээлийн эрх тогтоох',
                                      type: IOButtonType.primary,
                                      size: IOButtonSize.small,
                                    ),
                                  )
                                : IOButtonWidget(
                                    onPressed: () {},
                                    model: IOButtonModel(
                                      label: 'Зээл авах',
                                      type: IOButtonType.primary,
                                      size: IOButtonSize.small,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: IOCardBorderWidget(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Барьцаатай зээл", style: IOStyles.body2Bold),
                            const Spacer(),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/clock.svg',
                                  width: 12,
                                  height: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "2 сар ~ 36 сар",
                                  style: IOStyles.caption2Bold.copyWith(
                                    color: IOColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              'Боломжит хэмжээ',
                              style: IOStyles.caption1Regular.copyWith(
                                color: IOColors.brand500,
                              ),
                            ),
                            Text(
                              "30% ~ 80% хүртэл",
                              style: IOStyles.body2Semibold.copyWith(
                                color: IOColors.textSecondary,
                              ),
                            ),
                            const Spacer(),
                            IOButtonWidget(
                              onPressed: controller.onTapLoan,
                              model: IOButtonModel(
                                label: 'Зээлийн хүсэлт илгээх',
                                type: IOButtonType.primary,
                                size: IOButtonSize.small,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: GridView.count(
                  //     padding: const EdgeInsets.all(16),
                  //     mainAxisSpacing: 8,
                  //     crossAxisSpacing: 8,
                  //     crossAxisCount: 2,
                  //     childAspectRatio: 0.8,
                  //     children: controller.products
                  //         .map((e) => LoanTabProductWidget(item: e))
                  //         .toList(),
                  //   ),
                  // ),
                ],
              ),

              // GridView for the rest (products)

              // GridView.count(
              //   padding: const EdgeInsets.all(16),
              //   mainAxisSpacing: 8,
              //   crossAxisSpacing: 8,
              //   crossAxisCount: 2,
              //   childAspectRatio: 0.8,
              //   children: [
              //     IOCardBorderWidget(
              //       padding: const EdgeInsets.all(16),
              //       width: double.infinity,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.stretch,
              //         children: [
              //           Text("Барьцаагүй зээл", style: IOStyles.body2Bold),
              //           const Spacer(),
              //           Row(
              //             children: [
              //               SvgPicture.asset(
              //                 'assets/icons/clock.svg',
              //                 width: 12,
              //                 height: 12,
              //               ),
              //               const SizedBox(width: 4),
              //               Text(
              //                 "7 хоног ~ 12 сар",
              //                 style: IOStyles.caption2Bold.copyWith(
              //                   color: IOColors.textTertiary,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           const Spacer(),
              //           Text(
              //             'Боломжит хэмжээ',
              //             style: IOStyles.caption1Regular.copyWith(
              //               color: IOColors.brand500,
              //             ),
              //           ),
              //           Text(
              //             "5,000,000₮ хүртэл",
              //             style: IOStyles.body2Semibold.copyWith(
              //               color: IOColors.textSecondary,
              //             ),
              //           ),
              //           const Spacer(),
              //           IOButtonWidget(
              //             onPressed: () {},
              //             model: IOButtonModel(
              //               label: 'Зээлжих эрх тогтоох',
              //               type: IOButtonType.primary,
              //               size: IOButtonSize.small,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     ...controller.products.map(
              //       (e) => LoanTabProductWidget(item: e),
              //     ),
              //   ],
              // ),
            ),
    );

    // GridView.count(
    //   padding: const EdgeInsets.all(16),
    //   mainAxisSpacing: 8,
    //   crossAxisSpacing: 8,
    //   crossAxisCount: 2,
    //   childAspectRatio: 0.8,
    //   children: [
    //     Column(
    //       children: [
    //         Expanded(
    //           child: IOCardBorderWidget(
    //             padding: const EdgeInsets.all(16),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: [
    //                 Text("item.name", style: IOStyles.body2Bold),
    //                 const Spacer(),
    //                 Row(
    //                   children: [
    //                     SvgPicture.asset(
    //                       'assets/icons/clock.svg',
    //                       width: 12,
    //                       height: 12,
    //                     ),
    //                     const SizedBox(width: 4),
    //                     Text(
    //                       "item.duration",
    //                       style: IOStyles.caption2Bold.copyWith(
    //                         color: IOColors.textTertiary,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const Spacer(),
    //                 Text(
    //                   'Боломжит хэмжээ',
    //                   style: IOStyles.caption1Regular.copyWith(
    //                     color: IOColors.brand500,
    //                   ),
    //                 ),
    //                 Text(
    //                   "item.advancePayment",
    //                   style: IOStyles.body2Semibold.copyWith(
    //                     color: IOColors.textSecondary,
    //                   ),
    //                 ),
    //                 const Spacer(),
    //                 IOButtonWidget(
    //                   onPressed: () {},
    //                   model: IOButtonModel(
    //                     label: 'Хүсэлт илгээх',
    //                     type: IOButtonType.primary,
    //                     size: IOButtonSize.small,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Obx(
    //           () => controller.isInitialLoading.value
    //               ? const IOLoading()
    //               : IORefresher(
    //                   controller: controller.refresher,
    //                   onRefresh: controller.onRefresh,
    //                   child: GridView.count(
    //                     padding: const EdgeInsets.all(16),
    //                     mainAxisSpacing: 8,
    //                     crossAxisSpacing: 8,
    //                     crossAxisCount: 2,
    //                     childAspectRatio: 0.8,
    //                     children: controller.products
    //                         .map((e) => LoanTabProductWidget(item: e))
    //                         .toList(),
    //                   ),
    //                 ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
