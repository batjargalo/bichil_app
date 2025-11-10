import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:bichil/library/library.dart';

class IOAlert extends StatelessWidget {
  final IOAlertType type;
  final String? titleText;
  final String bodyText;
  final String? acceptText;
  final String? cancelText;

  final bool dismissable;
  const IOAlert({
    super.key,
    required this.type,
    required this.bodyText,
    this.dismissable = true,
    this.titleText,
    this.acceptText,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: IOColors.backgroundPrimary,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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
                    IOAlertType.success => IOColors.infoSecondary,
                    IOAlertType.error => IOColors.errorSecondary,
                    IOAlertType.warning => IOColors.warningSecondary,
                  },
                ),
                child: SvgPicture.asset(
                  type.image,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    switch (type) {
                      IOAlertType.success => IOColors.infoPrimary,
                      IOAlertType.error => IOColors.errorPrimary,
                      IOAlertType.warning => IOColors.warningPrimary,
                    },
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              titleText ?? type.text,
              textAlign: TextAlign.center,
              style: IOStyles.h6.copyWith(
                color: IOColors.brand700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              bodyText,
              maxLines: 15,
              textAlign: TextAlign.center,
              style: IOStyles.body1Regular.copyWith(
                color: IOColors.brand700,
              ),
            ),
            if (acceptText != null || cancelText != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  children: [
                    if (cancelText != null)
                      Expanded(
                        child: IOButtonWidget(
                          onPressed: Get.back,
                          model: IOButtonModel(
                            label: cancelText ?? 'Үгүй',
                            type: IOButtonType.secondary,
                            size: IOButtonSize.medium,
                          ),
                        ),
                      ),
                    if (acceptText != null && cancelText != null)
                      const SizedBox(width: 16),
                    if (acceptText != null)
                      Expanded(
                        child: IOButtonWidget(
                          onPressed: () => Get.back(result: true),
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

            // if (buttonText != null) ...[
            //   const SizedBox(height: 40),
            //   IOButtonWidget(
            //     model: IOButtonModel(
            //       type: IOButtonType.primary,
            //       size: IOButtonSize.medium,
            //       label: buttonText ?? '',
            //     ),
            //     onPressed: () {
            //       Get.back();
            //     },
            //   ),
            // ],
          ],
        ),
      ),
    );
  }

  Future<bool?> show() async {
    return Get.dialog(
      this,
      barrierDismissible: dismissable,
    );
  }
}

enum IOAlertType {
  success(
    text: 'Амжилттай',
    image: 'assets/icons/success.svg',
  ),
  error(
    text: 'Анхаарна уу',
    image: 'assets/icons/info.svg',
  ),
  warning(
    text: 'Анхаарна уу',
    image: 'assets/icons/info.svg',
  );

  const IOAlertType({required this.text, required this.image});

  final String text;
  final String image;
}
