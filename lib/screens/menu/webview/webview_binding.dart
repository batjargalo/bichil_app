import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class WebviewBinding extends Bindings {
  final String title;
  final String urlString;
  WebviewBinding({
    required this.title,
    required this.urlString,
  });

  @override
  void dependencies() {
    Get.lazyPut(() => WebviewController(
          title: title,
          urlString: urlString,
        ));
  }
}
