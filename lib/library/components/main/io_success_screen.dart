import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IOSuccessScreen extends StatelessWidget {
  final String title;
  final String description;
  final String? buttonText;
  const IOSuccessScreen({
    super.key,
    required this.title,
    required this.description,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: IOScaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          backgroundColor: IOColors.backgroundSecondary,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 96,
                  height: 96,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: IOColors.infoSecondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/success.svg',
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: IOStyles.h6,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: IOStyles.body2Regular.copyWith(
                    color: IOColors.textSecondary,
                  ),
                ),
                const Spacer(),
                IOButtonWidget(
                  onPressed: () => Get.back(result: true),
                  model: IOButtonModel(
                    label: buttonText ?? 'Дуусгах',
                    type: IOButtonType.primary,
                    size: IOButtonSize.medium,
                    isExpanded: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
