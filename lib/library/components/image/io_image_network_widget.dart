import 'package:cached_network_image/cached_network_image.dart';
import 'package:bichil/library/library.dart';

class IOImageNetworkWidget extends CachedNetworkImage {
  final String url;

  IOImageNetworkWidget({
    super.key,
    super.fit,
    required this.url,
    double placeHolderIconSize = 30,
  }) : super(
          imageUrl: url.contains('http')
              ? url
              : url.contains('/media')
                  ? '$domain$url'
                  : '$domain/media/$url',
          errorWidget: (context, url, error) {
            return IOImagePlaceholderWidget(
              iconSize: placeHolderIconSize,
            );
          },
          placeholder: (context, url) {
            return IOImagePlaceholderWidget(
              iconSize: placeHolderIconSize,
            );
          },
        );
}
