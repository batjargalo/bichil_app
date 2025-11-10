import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class NewsListWidget extends StatelessWidget {
  final NewsModel news;
  final ValueChanged<NewsModel> onTap;
  const NewsListWidget({
    super.key,
    required this.news,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () => onTap(news),
      child: IOCardBorderWidget(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
              child: SizedBox.square(
                dimension: 104,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: IOImageNetworkWidget(
                    url: news.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      news.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: IOStyles.body2Semibold.copyWith(
                        color: IOColors.brand500,
                      ),
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
