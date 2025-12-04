import 'package:bichil/library/library.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DigitalLoanLimitDanController extends IOController {
  final webController = WebViewController();
  final danUrl = '$domain/api/user/authorize?score=true';
  @override
  void onInit() {
    super.onInit();
    webController
      // ..setBackgroundColor(IOColors.backgroundSecondary)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isInitialLoading.value = true;
          },
          onPageFinished: (String url) {
            isInitialLoading.value = false;
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('sms:')) {
            //   launchUrlString(request.url);
            //   return NavigationDecision.prevent;
            // }
            if (request.url.startsWith('https://api.bichilglobus.mn/. /user/callback-dan')) {
              getData(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(danUrl),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${HelperManager.token.access}"},
      );
  }

  Future getData(String urlString) async {
    isLoading.value = true;

    try {
      final response = await Dio().get(urlString);
      final res = IOClient.getResponse(response);
      if (res.isSuccess) {
        Get.back();
        LoanRoute.toDigitalLoanContract();
      } else {
        Get.back();
        showError(text: res.message);
      }
    } on DioException catch (error) {
      final response = IOClient.getErrorResponse(error);
      Get.back();
      showError(text: response.message);
    }
  }
}
