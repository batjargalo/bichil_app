import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchCountrySheet extends StatelessWidget {
  final String title;
  final List<String> names;
  final List<int> counts;

  const BranchCountrySheet({
    super.key,
    required this.title,
    required this.names,
    required this.counts,
  });

  Future<int?> show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: IOColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              IOSliverHeader(
                pinned: true,
                min: 76,
                max: 76,
                child: Container(
                  decoration: const BoxDecoration(
                    color: IOColors.backgroundPrimary,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 4,
                            width: 40,
                            decoration: BoxDecoration(
                              color: IOColors.textQuarternary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: IOStyles.body1Bold,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, index) {
                  return IOGesture(
                    onTap: () => Get.back(result: index),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            names[index],
                            style: IOStyles.caption1SemiBold,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${counts[index]})',
                            style: IOStyles.caption1SemiBold.copyWith(
                              color: IOColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 1, thickness: 1);
                },
                itemCount: names.length,
              ),
              const SliverSafeArea(
                sliver: SliverToBoxAdapter(
                  child: Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
