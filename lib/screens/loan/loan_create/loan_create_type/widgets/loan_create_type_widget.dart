import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoanCreateTypeWidget extends StatelessWidget {
  final LoanProductModel model;
  final ValueChanged<LoanProductModel> onTap;

  const LoanCreateTypeWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () => onTap(model),
      child: IOCardBorderWidget(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    model.name,
                    style: IOStyles.body2Semibold,
                  ),
                ),
                const SizedBox(width: 16),
                SvgPicture.asset(
                  'assets/icons/chevron.right.svg',
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1),
            Row(
              children: [
                SizedBox(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Зээлийн хэмжээ',
                        style: IOStyles.caption1Regular.copyWith(
                          color: IOColors.textSecondary,
                        ),
                      ),
                      Text(
                        model.maxAmount.toCurrency(),
                        style: IOStyles.caption1Bold,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Зээлийн хүү',
                        style: IOStyles.caption1Regular.copyWith(
                          color: IOColors.textSecondary,
                        ),
                      ),
                      Text(
                        model.interest,
                        style: IOStyles.caption1Bold,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Зээлийн хугацаа',
                        style: IOStyles.caption1Regular.copyWith(
                          color: IOColors.textSecondary,
                        ),
                      ),
                      Text(
                        model.duration,
                        style: IOStyles.caption1Bold,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Үнэлгээ',
                        style: IOStyles.caption1Regular.copyWith(
                          color: IOColors.textSecondary,
                        ),
                      ),
                      Text(
                        model.advancePayment,
                        style: IOStyles.caption1Bold,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
