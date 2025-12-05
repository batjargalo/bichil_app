import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoDetailController extends IOController {
  final VideoListModel video;
  late final controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(video.videoUrl) ?? '',
      autoPlay: true,
      params: const YoutubePlayerParams(
        enableCaption: false,
        enableJavaScript: false,
      ));
  VideoDetailController({required this.video});

  @override
  void onInit() {
    super.onInit();
    _setOrientation();
  }

  @override
  void onClose() {
    _resetOrientation();
    controller.close();
    super.onClose();
  }

  void _setOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void _resetOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}
