import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ForceUpdateScreen extends StatelessWidget {
  final ForceUpdateModel model;
  const ForceUpdateScreen({super.key, required this.model});

  show() {
    return Get.bottomSheet(
      this,
      isDismissible: !model.forceUpdate,
      enableDrag: !model.forceUpdate,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: IOColors.textTertiary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Шинэчлэлүүд',
                style: IOStyles.body1Bold,
              ),
              const SizedBox(height: 16),
              Text(
                model.message,
                style: IOStyles.body1Regular,
              ),
              const SizedBox(height: 32),
              IOButtonWidget(
                onPressed: onTapUpdate,
                model: IOButtonModel(
                  label: 'Шинэчлэх',
                  type: IOButtonType.primary,
                  size: IOButtonSize.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapUpdate() {
    launchUrlString(
      model.url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
  }
}
