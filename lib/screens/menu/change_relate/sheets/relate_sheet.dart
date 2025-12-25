import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RelateSheet extends StatelessWidget {
  final List<RelatedModel> relation;
  const RelateSheet({super.key, required this.relation});

  Future<RelatedModel?> show() {
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
                              'Хэн болох',
                              textAlign: TextAlign.center,
                              style: IOStyles.body1Bold,
                            ),
                          ),
                        ),
                      ),
                      const Divider(height: 1, thickness: 1),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = relation[index];
                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          Get.back(result: relation[index]);
                        },
                        title: Text(
                          item.relation,
                          style: IOStyles.body2Semibold,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(height: 1, thickness: 1);
                  },
                  itemCount: relation.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RelatedModel {
  final String value;
  final String relation;
  RelatedModel({required this.value, required this.relation});
}
