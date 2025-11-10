import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchMapInfoWidget extends StatelessWidget {
  final BranchModel branch;
  const BranchMapInfoWidget({
    super.key,
    required this.branch,
  });

  show() {
    return Get.bottomSheet(this, isScrollControlled: true);
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: IOImageNetworkWidget(
                        url: branch.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                branch.title,
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.brand500,
                ),
              ),
              Text(
                branch.description,
                style: IOStyles.body2Regular.copyWith(
                  color: IOColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${branch.week}: ${branch.time}',
                style: IOStyles.caption1SemiBold,
              ),
              const SizedBox(height: 8),
              Text(
                'Утас: ${branch.contact}',
                style: IOStyles.caption1SemiBold,
              ),
              const SizedBox(height: 16),
              if (branch.contact.isNotEmpty) ...[
                IOButtonWidget(
                  onPressed: callToPhone,
                  model: IOButtonModel(
                    label: 'Залгах',
                    type: IOButtonType.primary,
                    size: IOButtonSize.medium,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void callToPhone() {
    final phoneList = branch.contact.split(',').map((e) => e.trim()).toList();
    if (phoneList.isNotEmpty) {
      final Uri callLaunchUri = Uri(
        scheme: 'tel',
        path: phoneList.first,
      );

      launchUrl(callLaunchUri);
    }
  }
}
