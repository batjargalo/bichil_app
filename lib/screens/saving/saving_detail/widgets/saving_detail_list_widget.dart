import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SavingDetailListWidget extends StatelessWidget {
  final List<SavingDetailAction> actions;
  final ValueChanged<SavingDetailAction> onTap;
  const SavingDetailListWidget({
    super.key,
    required this.actions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = actions[index];
          return IOGesture(
            onTap: () => onTap(item),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.title,
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
        itemCount: actions.length,
      ),
    );
  }
}
