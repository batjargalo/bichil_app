import 'package:bichil/library/library.dart';
import 'package:bichil/screens/home/home.dart';
import 'package:flutter/material.dart';

class HomeLoanWidget extends StatelessWidget {
  final HomeProductModel model;
  final ValueChanged<HomeProductModel> onTap;
  const HomeLoanWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () => onTap(model),
      child: IOCardBorderWidget(
        width: 160,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: IOImageNetworkWidget(
                    url: model.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      model.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: IOStyles.body2Semibold,
                    ),
                  ),
                  IOIconWidget(
                    model: IOIconModel(
                      type: IOIconType.svg,
                      icon: 'chevron.right.svg',
                      width: 24,
                      height: 24,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
