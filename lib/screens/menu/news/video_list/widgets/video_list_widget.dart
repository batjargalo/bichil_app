import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class VideoListWidget extends StatelessWidget {
  final VideoListModel model;
  final ValueChanged<VideoListModel> onTap;
  const VideoListWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () => onTap(model),
      child: IOCardBorderWidget(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: IOImageNetworkWidget(
                  url: model.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                model.title,
                style: IOStyles.body2Semibold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
