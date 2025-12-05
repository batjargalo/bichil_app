import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class SignUpPageController extends IOController {
  final pageController = PageController();
  final model = SignUpModel();

  final screens = const [
    SignUpPhoneScreen(),
    SignUpOtpScreen(),
    SignUpInfoScreen(),
    SignUpPasswordScreen(),
  ];

  void lastPage() {
    final index = screens.length - 1;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
