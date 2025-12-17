import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PinCheckScreen extends StatelessWidget {
  const PinCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PinCheckController(),
      builder: (controller) {
        return IODialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: IOColors.brand50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  'assets/icons/key.svg',
                  colorFilter: const ColorFilter.mode(
                    IOColors.brand500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Та гүйлгээний нууц үгээ хийнэ үү',
                style: IOStyles.body2Bold,
              ),
              const SizedBox(height: 24),
              IOOtpWidget(model: controller.pin),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: controller.onForgot,
                child: Text(
                  controller.forgetText,
                  style: IOStyles.body2Bold.copyWith(
                    color: IOColors.brand500,
                    decoration: TextDecoration.underline,
                    decorationColor: IOColors.brand500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> show() {
    return Get.dialog(this);
  }
}
