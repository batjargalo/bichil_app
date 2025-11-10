import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class MenuRoute {
  static toUserInfo() {
    Get.to(
      () => const UserInfoScreen(),
      binding: UserInfoBinding(),
    );
  }

  static toUserDelete() {
    Get.to(
      () => const UserDeleteScreen(),
      binding: UserDeleteBinding(),
    );
  }

  static toChangeBank() {
    return Get.to(
      () => const ChangeBankScreen(),
      binding: ChangeBankBinding(),
    );
  }

  static Future<bool?>? toChangeEmail() {
    return Get.to(
      () => const ChangeEmailScreen(),
      binding: ChangeEmailBinding(),
    );
  }

  static toChangePhoneNumber() {
    Get.to(
      () => const ChangePhoneNumberScreen(),
      binding: ChangePhoneNumberBinding(),
    );
  }

  static toChangePhoneOtp({
    required String phone,
    required String otpToken,
  }) {
    Get.to(
      () => const ChangePhoneOtpScreen(),
      binding: ChangePhoneOtpBinding(
        phone: phone,
        otpToken: otpToken,
      ),
    );
  }

  static toChangePassword() {
    Get.to(
      () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    );
  }

  static Future<String?>? toChangePin() {
    return Get.to(
      () => const PinChangeScreen(),
      binding: PinChangeBinding(),
    );
  }

  static toBranch() {
    Get.to(
      () => const BranchScreen(),
      binding: BranchBinding(),
    );
  }

  static toCalculator() {
    Get.to(
      () => const CalculatorScreen(),
      binding: CalculatorBinding(),
    );
  }

  static toContact() {
    Get.to(
      () => const ContactScreen(),
      binding: ContactBinding(),
    );
  }

  static toFaq() {
    Get.to(
      () => const FaqScreen(),
      binding: FaqBinding(),
    );
  }

  static toWeb({required String title, required String url}) {
    Get.to(
      () => const WebviewScreen(),
      binding: WebviewBinding(title: title, urlString: url),
    );
  }

  static toTerms() {
    toWeb(
      title: MenuTabItemType.terms.title,
      url: '$domain/api/info/service-terms',
    );
  }

  static toNewsPage() {
    Get.to(
      () => const NewsPageScreen(),
      binding: NewsPageBinding(),
    );
  }

  static toNewsDetail({required NewsModel news}) {
    Get.to(
      () => const NewsDetailScreen(),
      binding: NewsDetailBinding(news: news),
    );
  }

  static toVideoDetail({required VideoListModel video}) {
    Get.to(
      () => const VideoDetailScreen(),
      binding: VideoDetailBinding(video: video),
    );
  }
}
