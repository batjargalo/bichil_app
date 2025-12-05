import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignInUserScreen extends GetView<SignInUserController> {
  static const routeName = '/SignInUserScreen';

  const SignInUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IOScaffold(
        key: controller.key,
        extendBodyBehindAppBar: true,
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
        drawer: const MenuLeftScreen(),
        body: AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: SizedBox.expand(
            child: GestureDetector(
              onTap: Get.focusScope?.unfocus,
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 40,
                              bottom: 70,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/logo.full.svg',
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              width: 195,
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: Get.mediaQuery.padding.top +
                              AppBar().preferredSize.height +
                              40 +
                              40 +
                              50,
                        ),
                        child: Column(
                          children: [
                            IOTextfieldWidget(model: controller.phoneField),
                            const SizedBox(height: 20),
                            IOTextfieldWidget(model: controller.passField),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IOGesture(
                                  onTap: controller.onTapReset,
                                  child: const Text(
                                    'Нууц үг мартсан',
                                    style: IOStyles.caption1Regular,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: IOBottomNavigationBar(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SignInFaceWidget(
                checked: controller.isCheckedBiometric.value,
                onTap: controller.isCheckedBiometric.call,
              ),
              const SizedBox(height: 12),
              IOButtonWidget(
                model: controller.signInButton.value,
                onPressed: controller.onTapSignIn,
              ),
              const SizedBox(height: 16),
              IOButtonWidget(
                model: controller.signUpButton,
                onPressed: controller.onTapSignUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
