import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignInBioScreen extends GetView<SignInBioController> {
  static const routeName = '/SignInBioScreen';
  const SignInBioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      key: controller.key,
      extendBodyBehindAppBar: true,
      drawer: const MenuLeftScreen(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: controller.onTapMenu,
          icon: SvgPicture.asset(
            'assets/icons/menu.svg',
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      IOColors.brand400,
                      IOColors.brand600,
                    ],
                  ),
                  image: DecorationImage(
                    repeat: ImageRepeat.repeat,
                    image: AssetImage(
                      'assets/images/pattern.png',
                    ),
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 50,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/user.placeholder.svg',
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Сайн байна уу?',
                            style: IOStyles.body1SemiBold.copyWith(
                              color: IOColors.backgroundPrimary,
                            ),
                          ),
                          Text(
                            controller.bio.username,
                            style: IOStyles.h4.copyWith(
                              color: IOColors.backgroundPrimary,
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      IOButtonWidget(
                        model: controller.signInButton.value,
                        onPressed: controller.onTapSignIn,
                      ),
                      const SizedBox(height: 16),
                      IOButtonWidget(
                        model: controller.newButton,
                        onPressed: controller.onBack,
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
