import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class NotificationPrivateWidget extends StatelessWidget {
  final NotificationModel model;
  final ValueChanged<NotificationModel> onTap;
  const NotificationPrivateWidget({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                if (model.state == 'not-read')
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: const BoxDecoration(
                      color: IOColors.successPrimary,
                      shape: BoxShape.circle,
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: IOColors.brand50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    switch (model.action) {
                      'loan' => 'Зээл авалт',
                      'loan_history' => 'Зээлийн түүх',
                      'saving' => 'Итгэлцэл',
                      'saving_history' => 'Итгэлцлийн түүх',
                      _ => 'Хэрэглэгч',
                    },
                    style: IOStyles.caption2SemiBold.copyWith(
                      color: IOColors.brand500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              model.text,
              style: IOStyles.caption1SemiBold,
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
    );
  }
}
