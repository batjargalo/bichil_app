import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class VideoDetailBinding extends Bindings {
  final VideoListModel video;
  VideoDetailBinding({required this.video});

  @override
  void dependencies() {
    Get.lazyPut(() => VideoDetailController(video: video));
  }
}
