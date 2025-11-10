import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class NotificationNewsWidget extends StatelessWidget {
  final NotificationModel model;
  final ValueChanged<NotificationModel> onTap;
  const NotificationNewsWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () => onTap(model),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: Text(
                        model.text,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: IOStyles.caption1SemiBold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.createdDate.toFormattedString(format: 'yyyy-MM-dd'),
                      style: IOStyles.caption1Regular.copyWith(
                        color: IOColors.textSecondary,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
