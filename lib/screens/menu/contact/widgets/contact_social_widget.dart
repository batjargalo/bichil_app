import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class ContactSocialWidget extends StatelessWidget {
  final List<ContactSocialModel> items;
  final ValueChanged<ContactSocialModel> onTap;
  const ContactSocialWidget({
    super.key,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = items[index];
          return ContactItemWidget(
            icon: item.icon,
            title: item.name,
            description: item.link,
            onTap: () => onTap(item),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 1, thickness: 1);
        },
        itemCount: items.length,
      ),
    );
  }
}
