import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MenuLeftScreen extends GetView<MenuLeftController> {
  const MenuLeftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: IOScaffold(
        appBar: AppBar(
          backgroundColor: IOColors.backgroundSecondary,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/logo.full.svg',
                height: 40,
                width: 190,
              ),
              const Spacer(),
              MenuLeftWidget(
                icon: 'location.svg',
                title: 'Хаяг, Байршил',
                onTap: controller.onTapBranch,
              ),
              const Divider(height: 1, thickness: 1),
              MenuLeftWidget(
                icon: 'phone.svg',
                title: 'Холбоо барих',
                onTap: controller.onTapCall,
              ),
              const Divider(height: 1, thickness: 1),
              MenuLeftWidget(
                icon: 'question.svg',
                title: 'Түгээмэл асуулт хариулт',
                onTap: controller.onTapFaq,
              ),
              const Spacer(flex: 5),
              FutureBuilder(
                future: HelperManager.version,
                builder: (_, snapshot) {
                  return Text(
                    snapshot.data ?? '',
                    style: IOStyles.body1Medium,
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
