import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class NewsListFirstWidget extends StatelessWidget {
  final NewsModel news;
  final ValueChanged<NewsModel> onTap;

  const NewsListFirstWidget({
    super.key,
    required this.news,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () => onTap(news),
      child: IOCardBorderWidget(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: IOImageNetworkWidget(
                  url: news.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    news.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: IOStyles.body2Semibold,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    news.publishedDate.toFormattedString(
                      format: 'yyyy/MM/dd',
                    ),
                    style: IOStyles.caption1Regular.copyWith(
                      color: IOColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
