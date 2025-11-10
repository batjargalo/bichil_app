import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactController extends IOController {
  final titleText = 'Холбоо барих';
  final item = ContactModel.fromJson(JSON.nil).obs;

  final info = <ContactSocialModel>[].obs;
  final social = <ContactSocialModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getContact();
  }

  Future getContact() async {
    isInitialLoading.value = true;
    final response = await InfoApi().getContact();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      item.value = ContactModel.fromJson(response.data);
      setData();
    } else {
      Get.back;
      showError(text: response.message);
    }
  }

  void setData() {
    final e = item.value;
    info.value = [
      ContactSocialModel(
        linkType: ContactSocialType.phone,
        icon: 'phone.svg',
        name: 'Утас',
        link: e.phone,
      ),
      ContactSocialModel(
        linkType: ContactSocialType.mail,
        icon: 'mail.svg',
        name: 'Мэйл хаяг',
        link: e.email,
      ),
      ContactSocialModel(
        linkType: ContactSocialType.link,
        icon: 'web.svg',
        name: 'Веб сайт',
        link: e.web,
      ),
    ];
    social.value = [
      if (e.facebook.isNotEmpty)
        ContactSocialModel(
          linkType: ContactSocialType.link,
          icon: 'social.facebook.svg',
          name: 'Facebook',
          link: e.facebook,
        ),
      if (e.instagram.isNotEmpty)
        ContactSocialModel(
          linkType: ContactSocialType.link,
          icon: 'social.instagram.svg',
          name: 'Instagram',
          link: e.instagram,
        ),
      if (e.youtube.isNotEmpty)
        ContactSocialModel(
          linkType: ContactSocialType.link,
          icon: 'social.youtube.svg',
          name: 'Youtube',
          link: e.youtube,
        ),
    ];
  }

  void onTapAction(ContactSocialModel item) {
    switch (item.linkType) {
      case ContactSocialType.phone:
        onCallToPhone(item.link);
        break;
      case ContactSocialType.mail:
        onSendToMail(item.link);
        break;
      case ContactSocialType.link:
        onOpenToLink(item.link);
        break;
    }
  }

  Future onCallToPhone(String value) async {
    final Uri callLaunchUri = Uri(
      scheme: 'tel',
      path: value,
    );

    launchUrl(callLaunchUri);
  }

  Future onOpenToLink(String value) async {
    if (await canLaunchUrlString(value)) {
      await launchUrlString(
        value,
        mode: LaunchMode.externalApplication,
      );
    } else {
      showError(text: 'Хуудас нээхэд алдаа гарлаа');
    }
  }

  Future onSendToMail(String value) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: value,
      query: encodeQueryParameters(<String, String>{
        'subject': '',
      }),
    );

    launchUrl(emailLaunchUri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
