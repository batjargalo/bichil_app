import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoanPledgeListScreen extends GetView<LoanPledgeListController> {
  const LoanPledgeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: 'Барьцаа хөрөнгө',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: IOCardBorderWidget(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = controller.items[index];
              return IOGesture(
                onTap: () => () {},
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.acntName,
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
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 1, thickness: 1);
            },
            itemCount: controller.items.length,
          ),
        ),
      ),
    );
  }
}
