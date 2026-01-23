import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanTabScreen extends GetView<LoanTabController> {
  const LoanTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // appBar: TabBarAppBarWidget(
        //   count: controller.tab.notificationCount.value,
        //   name: controller.user.value.firstName,
        //   hasEye: true,
        //   isEyeOn: !controller.isSecure.value,
        //   onTapEye: controller.onTapEye,
        //   onTapNotfication: controller.onTapNotfication,
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: controller.isInitialLoading.value
                  ? const IOLoading()
                  : IORefresher(
                      controller: controller.refresher,
                      onRefresh: controller.onRefresh,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: controller.loans.length,
                        itemBuilder: (context, index) {
                          final item = controller.loans[index];
                          return LoanTabItemWidget(
                            // isSecure: controller.isSecure.value,
                            // isSecure: false,
                            item: item,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16);
                        },
                      ),
                      // child: CustomScrollView(
                      //   slivers: [
                      //     if (controller.loan.value != null) ...[
                      //       const SliverToBoxAdapter(
                      //         child: SizedBox(height: 16),
                      //       ),
                      //       SliverPadding(
                      //         padding: const EdgeInsets.symmetric(
                      //           horizontal: 16,
                      //         ),
                      //         sliver: SliverToBoxAdapter(
                      //           child: LoanTabScoringWidget(
                      //             isSecure: controller.isSecure.value,
                      //             model: controller.loan.value!,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //     const SliverToBoxAdapter(
                      //       child: SizedBox(height: 16),
                      //     ),
                      //     SliverList.separated(
                      //       itemCount: controller.loans.length,
                      //       itemBuilder: (context, index) {
                      //         final item = controller.loans[index];
                      //         return Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //             horizontal: 16,
                      //           ),
                      //           child: LoanTabItemWidget(
                      //             isSecure: controller.isSecure.value,
                      //             item: item,
                      //           ),
                      //         );
                      //       },
                      //       separatorBuilder: (context, index) {
                      //         return const SizedBox(height: 16);
                      //       },
                      //     ),
                      //     const SliverToBoxAdapter(
                      //       child: SizedBox(height: 16),
                      //     ),
                      //   ],
                      // ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
