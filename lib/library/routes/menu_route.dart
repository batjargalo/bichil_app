import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class MenuRoute {
  static void toUserInfo() {
    Get.to(() => const UserInfoScreen(), binding: UserInfoBinding());
  }

  static void toUserDelete() {
    Get.to(() => const UserDeleteScreen(), binding: UserDeleteBinding());
  }

  static Future<dynamic>? toChangeBank() {
    return Get.to(() => const ChangeBankScreen(), binding: ChangeBankBinding());
  }

  static Future<bool?>? toChangeEmail() {
    return Get.to(
      () => const ChangeEmailScreen(),
      binding: ChangeEmailBinding(),
    );
  }

  static void toChangePhoneNumber() {
    Get.to(
      () => const ChangePhoneNumberScreen(),
      binding: ChangePhoneNumberBinding(),
    );
  }

  static void toChangePhoneOtp({
    required String phone,
    required String otpToken,
  }) {
    Get.to(
      () => const ChangePhoneOtpScreen(),
      binding: ChangePhoneOtpBinding(phone: phone, otpToken: otpToken),
    );
  }

  static void toChangePassword() {
    Get.to(
      () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    );
  }

  static Future<String?>? toChangePin() {
    return Get.to(() => const PinChangeScreen(), binding: PinChangeBinding());
  }

  static void toBranch() {
    Get.to(() => const BranchScreen(), binding: BranchBinding());
  }

  static void toCalculator() {
    Get.to(() => const CalculatorScreen(), binding: CalculatorBinding());
  }

  static void toContact() {
    Get.to(() => const ContactScreen(), binding: ContactBinding());
  }

  static void toFaq() {
    Get.to(() => const FaqScreen(), binding: FaqBinding());
  }

  static void toWeb({required String title, required String url}) {
    Get.to(
      () => const WebviewScreen(),
      binding: WebviewBinding(title: title, urlString: url),
    );
  }

  static void toTerms() {
    toWeb(
      title: MenuTabItemType.terms.title,
      url: '$domain/api/info/service-terms',
    );
  }

  static void toNewsPage() {
    Get.to(() => const NewsPageScreen(), binding: NewsPageBinding());
  }

  static void toNewsDetail({required NewsModel news}) {
    Get.to(
      () => const NewsDetailScreen(),
      binding: NewsDetailBinding(news: news),
    );
  }

  static void toVideoDetail({required VideoListModel video}) {
    Get.to(
      () => const VideoDetailScreen(),
      binding: VideoDetailBinding(video: video),
    );
  }

  static void toChangeRelate({required UserRelatedModel person}) {
    Get.to(
      () => const ChangeRelateScreen(),
      binding: ChangeRelateBinding(person: person),
    );
  }
}
