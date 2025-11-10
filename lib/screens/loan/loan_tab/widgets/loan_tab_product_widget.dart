import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoanTabProductWidget extends StatelessWidget {
  final LoanProductModel item;

  const LoanTabProductWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return IOCardBorderWidget(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            item.name,
            style: IOStyles.body2Bold,
          ),
          const Spacer(),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/clock.svg',
                width: 12,
                height: 12,
              ),
              const SizedBox(width: 4),
              Text(
                item.duration,
                style: IOStyles.caption2Bold.copyWith(
                  color: IOColors.textTertiary,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'Боломжит хэмжээ',
            style: IOStyles.caption1Regular.copyWith(
              color: IOColors.brand500,
            ),
          ),
          Text(
            item.advancePayment,
            style: IOStyles.body2Semibold.copyWith(
              color: IOColors.textSecondary,
            ),
          ),
          const Spacer(),
          IOButtonWidget(
            onPressed: onTapProduct,
            model: IOButtonModel(
              label: 'Хүсэлт илгээх',
              type: IOButtonType.primary,
              size: IOButtonSize.small,
            ),
          ),
        ],
      ),
    );
  }

  void onTapProduct() {
    final result = SessionManager.shared.checkBankAccount();
    if (result == false) return;

    switch (item.collateralType) {
      case 'property':
        LoanRoute.toCreateProperty();
        break;
      case 'car':
        LoanRoute.toCreateCar();
        break;
      case 'phone_number':
        LoanRoute.toCreatePhone();
        break;
      default:
        break;
    }
  }
}
