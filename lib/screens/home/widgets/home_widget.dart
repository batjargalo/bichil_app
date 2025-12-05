import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeWidget extends StatelessWidget {
  final Axis direction;
  final String icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const HomeWidget({
    super.key,
    required this.direction,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: onTap,
      child: IOCardBorderWidget(
        padding: const EdgeInsets.all(16),
        child: switch (direction) {
          Axis.horizontal => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                image,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: body,
                  ),
                ),
              ],
            ),
          Axis.vertical => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image,
                const SizedBox(height: 12),
                ...body,
              ],
            ),
        },
      ),
    );
  }

  Widget get image => SizedBox.square(
        dimension: 60,
        child: Image.asset(
          'assets/images/$icon',
        ),
      );

  List<Widget> get body => [
        Text(
          title,
          style: IOStyles.body2Bold,
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                description,
                style: IOStyles.caption1Regular.copyWith(
                  color: IOColors.textSecondary,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/chevron.right.svg',
              colorFilter: const ColorFilter.mode(
                IOColors.brand500,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
          ],
        )
      ];
}
