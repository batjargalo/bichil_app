import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchListScreen extends GetView<BranchListController> {
  const BranchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isInitialLoading.value
          ? const IOLoading()
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: IOCardBorderWidget(
                      child: Column(
                        children: [
                          IODropdownWidget.custom(
                            model: controller.country,
                            onTap: controller.onTapCountry,
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          IODropdownWidget.custom(
                            model: controller.city,
                            onTap: controller.onTapCity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                controller.branchItem.isEmpty
                    ? const SliverToBoxAdapter(
                        child: IOEmptyWidget(),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList.separated(
                          itemBuilder: (context, index) {
                            final item = controller.branchItem[index];
                            return BranchListWidget(branch: item);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 16);
                          },
                          itemCount: controller.branchItem.length,
                        ),
                      ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Get.mediaQuery.padding.bottom + 16,
                  ),
                )
              ],
            ),
    );
  }
}
