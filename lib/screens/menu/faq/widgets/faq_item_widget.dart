import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class FaqItemWidget extends StatefulWidget {
  final FaqModel model;

  const FaqItemWidget({super.key, required this.model});

  @override
  State<FaqItemWidget> createState() => _FaqItemWidgetState();
}

class _FaqItemWidgetState extends State<FaqItemWidget> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: expanded,
      onExpansionChanged: (value) {
        setState(() {
          expanded = value;
        });
      },
      title: Text(
        widget.model.question,
        style: IOStyles.body2Semibold.copyWith(
          color: expanded ? IOColors.brand500 : IOColors.textPrimary,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          width: 1,
          color: IOColors.brand500,
        ),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          width: 1,
          color: IOColors.strokePrimary,
        ),
      ),
      iconColor: IOColors.brand500,
      collapsedIconColor: IOColors.textPrimary,
      backgroundColor: IOColors.backgroundPrimary,
      collapsedBackgroundColor: IOColors.backgroundPrimary,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            widget.model.answer,
            style: IOStyles.body2Regular.copyWith(
              color: IOColors.textTertiary,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
