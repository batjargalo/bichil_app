import 'package:flutter/material.dart';
import 'package:bichil/library/library.dart';

class IOAppBar extends AppBar {
  IOAppBar({
    super.key,
    super.bottom,
    super.leading,
    super.leadingWidth,
    super.actions,
    super.centerTitle,
    super.backgroundColor,
    String? titleText,
    Widget? title,
    bool hasCorner = true,
  }) : super(
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    IOColors.brand400,
                    IOColors.brand600,
                  ],
                ),
                borderRadius: hasCorner
                    ? const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      )
                    : null,
              ),
              child: Image.asset(
                'assets/images/pattern.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          title: title ??
              Text(
                titleText ?? '',
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.backgroundPrimary,
                ),
              ),
        );
}
