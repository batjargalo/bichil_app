import 'package:bichil/library/library.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends IOController {
  final String title;
  final String urlString;
  final webController = WebViewController();

  WebviewController({
    required this.title,
    required this.urlString,
  });

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
        ),
      )
      ..loadRequest(Uri.parse(urlString));
  }
}
