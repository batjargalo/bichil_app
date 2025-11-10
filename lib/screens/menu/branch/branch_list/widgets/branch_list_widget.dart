import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class BranchListWidget extends StatelessWidget {
  final BranchModel branch;
  const BranchListWidget({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130,
            height: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: IOImageNetworkWidget(
                url: branch.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    branch.title,
                    style: IOStyles.body2Semibold.copyWith(
                      color: IOColors.brand500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    branch.description,
                    style: IOStyles.caption1Regular.copyWith(
                      color: IOColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${branch.week}: ${branch.time}',
                    style: IOStyles.caption1Regular,
                  ),
                  Text(
                    'Утас: ${branch.contact}',
                    style: IOStyles.caption1Regular,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
