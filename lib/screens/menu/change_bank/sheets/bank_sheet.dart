import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankSheet extends StatelessWidget {
  final List<BankModel> banks;
  const BankSheet({super.key, required this.banks});

  Future<BankModel?> show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.8,
      builder: (context, scroll) {
        return Container(
          decoration: const BoxDecoration(
            color: IOColors.backgroundPrimary,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8),
            ),
          ),
          child: CustomScrollView(
            controller: scroll,
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
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Text(
                              'Банк',
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
              SliverToBoxAdapter(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = banks[index];
                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          Get.back(result: banks[index]);
                        },
                        leading: SizedBox.square(
                          dimension: 32,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: IOImageNetworkWidget(
                              url: item.image,
                              placeHolderIconSize: 20,
                            ),
                          ),
                        ),
                        title: Text(
                          item.name,
                          style: IOStyles.body2Semibold,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(height: 1, thickness: 1);
                  },
                  itemCount: banks.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
