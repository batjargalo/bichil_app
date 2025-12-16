import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:bichil/library/library.dart';

class IOWarning extends StatelessWidget {
  final IOWarningType type;
  final String? titleText;
  final String bodyText;
  final String? acceptText;

  final bool dismissable;
  const IOWarning({
    super.key,
    required this.type,
    required this.bodyText,
    this.dismissable = true,
    this.titleText,
    this.acceptText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: IOColors.backgroundPrimary,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: switch (type) {
                    IOWarningType.success => IOColors.infoSecondary,
                    IOWarningType.error => IOColors.errorSecondary,
                    IOWarningType.warning => IOColors.warningSecondary,
                  },
                ),
                child: SvgPicture.asset(
                  type.image,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(switch (type) {
                    IOWarningType.success => IOColors.infoPrimary,
                    IOWarningType.error => IOColors.errorPrimary,
                    IOWarningType.warning => IOColors.warningPrimary,
                  }, BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              titleText ?? type.text,
              textAlign: TextAlign.center,
              style: IOStyles.h6.copyWith(color: IOColors.brand700),
            ),
            const SizedBox(height: 12),
            Text(
              bodyText,
              maxLines: 15,
              textAlign: TextAlign.center,
              style: IOStyles.body1Regular.copyWith(color: IOColors.brand700),
            ),
            if (acceptText != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: IOButtonWidget(
                        onPressed: () => {Get.back(), MenuRoute.toChangePin()},
                        model: IOButtonModel(
                          label: acceptText ?? 'Тийм',
                          type: IOButtonType.primary,
                          size: IOButtonSize.medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<bool?> show() async {
    return Get.dialog(this, barrierDismissible: dismissable);
  }
}

enum IOWarningType {
  success(text: 'Амжилттай', image: 'assets/icons/success.svg'),
  error(text: 'Анхаарна уу?', image: 'assets/icons/info.svg'),
  warning(text: 'Анхаарна уу?', image: 'assets/icons/info.svg');

  const IOWarningType({required this.text, required this.image});

  final String text;
  final String image;
}
