import 'package:flutter/material.dart';
import 'package:bichil/library/library.dart';

class IOEmptyWidget extends StatelessWidget {
  final IOIconModel? icon;
  final String text;
  const IOEmptyWidget({
    super.key,
    this.icon,
    this.text = 'Илэрц хоосон',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            IOIconWidget(model: icon!),
            const SizedBox(height: 24),
          ],
          Text(
            text,
            textAlign: TextAlign.center,
            style: IOStyles.body1SemiBold.copyWith(
              color: IOColors.brand500,
            ),
          ),
        ],
      ),
    );
  }
}
