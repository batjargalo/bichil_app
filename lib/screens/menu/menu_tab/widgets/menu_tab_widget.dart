import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuTabWidget extends StatelessWidget {
  final MenuTabModel model;
  final Function(MenuTabItemType, bool?) onTap;
  const MenuTabWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (model.title.isNotEmpty)
          SizedBox(
            height: 56,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                model.title,
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.brand500,
                ),
              ),
            ),
          ),
        IOCardBorderWidget(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = model.items[index];

              return IOGesture(
                onTap: () => onTap(item.type, null),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.type.title,
                          overflow: TextOverflow.ellipsis,
                          style: IOStyles.body2Semibold,
                        ),
                      ),
                      item.value == null
                          ? SvgPicture.asset(
                              'assets/icons/chevron.right.svg',
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                IOColors.textPrimary,
                                BlendMode.srcIn,
                              ),
                            )
                          : IOSwitch(
                              value: item.value!,
                              onChanged: (v) => onTap(item.type, v),
                            ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                thickness: 1,
                color: IOColors.strokePrimary,
              );
            },
            itemCount: model.items.length,
          ),
        ),
      ],
    );
  }
}
