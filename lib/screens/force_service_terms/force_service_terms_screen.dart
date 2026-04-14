import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForceUpdateServiceTermsScreen extends StatelessWidget {
  final ForceUpdateServiceTermsModel model;
  const ForceUpdateServiceTermsScreen({super.key, required this.model});

  Future<dynamic> show() {
    return Get.bottomSheet(
      this,
      isDismissible: model.serviceTerm,
      enableDrag: model.serviceTerm,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top + 80),
      decoration: const BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                    decoration: BoxDecoration(color: IOColors.textTertiary, borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Expanded(
                child: WebViewWidget(
                  controller: WebViewController()..loadRequest(Uri.parse('$domain/api/info/service-terms')),
                ),
              ),
              const SizedBox(height: 16),
              IOButtonWidget(
                onPressed: onTapUpdate,
                model: IOButtonModel(label: 'Зөвшөөрөх', type: IOButtonType.primary, size: IOButtonSize.medium),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapUpdate() {
    UserApi().checkUserTerms();
    Get.back();
  }
}
