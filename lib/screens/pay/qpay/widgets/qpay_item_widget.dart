import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class QpayItemWidget extends StatelessWidget {
  final QpayModel url;
  final ValueChanged<QpayModel> onTap;
  const QpayItemWidget({
    super.key,
    required this.url,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () => onTap(url),
      child: IOCardBorderWidget(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.square(
              dimension: 32,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: IOImageNetworkWidget(
                  url: url.logo,
                  placeHolderIconSize: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              url.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: IOStyles.caption1Regular,
            ),
          ],
        ),
      ),
    );
  }
}
