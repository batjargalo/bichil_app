import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabBarAppBarWidget extends IOAppBar {
  TabBarAppBarWidget({
    super.key,
    required String name,
    required bool hasEye,
    int? count,
    bool? isEyeOn,
    VoidCallback? onTapEye,
    VoidCallback? onTapNotfication,
  }) : super(
          leadingWidth: 0,
          centerTitle: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Сайн байна уу',
                style: IOStyles.caption1SemiBold.copyWith(
                  color: IOColors.backgroundPrimary,
                ),
              ),
              Text(
                name,
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.backgroundPrimary,
                ),
              ),
            ],
          ),
          actions: [
            if (hasEye)
              IconButton(
                onPressed: onTapEye,
                icon: SvgPicture.asset(
                  isEyeOn ?? false
                      ? 'assets/icons/eye.on.svg'
                      : 'assets/icons/eye.off.svg',
                  colorFilter: const ColorFilter.mode(
                    IOColors.backgroundPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: onTapNotfication,
                icon: Badge.count(
                  count: count ?? 0,
                  isLabelVisible: (count ?? 0) != 0,
                  child: SvgPicture.asset(
                    'assets/icons/notification.svg',
                    colorFilter: const ColorFilter.mode(
                      IOColors.backgroundPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
}
