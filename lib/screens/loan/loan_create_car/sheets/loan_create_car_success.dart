import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_json/g_json.dart';
import 'package:get/get.dart';

class LoanCreateCarSuccess extends StatelessWidget {
  final String title;
  final JSON data;

  const LoanCreateCarSuccess({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    print(data);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: IOScaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          backgroundColor: IOColors.backgroundSecondary,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 96,
                  height: 96,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: IOColors.infoSecondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/success.svg',
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: IOStyles.h6,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: IOColors.brand50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Урьдчилсан зээлийн эрх',
                        textAlign: TextAlign.center,
                        style: IOStyles.caption1SemiBold.copyWith(
                          color: IOColors.brand500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${data['price'].stringValue}₮',
                        textAlign: TextAlign.center,
                        style: IOStyles.h3.copyWith(
                          color: IOColors.brand500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                IOCardBorderWidget(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      RowWidget(
                        title: 'Улсын дугаар',
                        value: data['plate_no'].stringValue,
                      ),
                      const SizedBox(height: 16),
                      RowWidget(
                        title: 'Марк',
                        value: data['mark'].stringValue,
                      ),
                      const SizedBox(height: 16),
                      RowWidget(
                        title: 'Модель',
                        value: data['model'].stringValue,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Та салбарт очин өөрийн орлогод тохирсон зээлээ авах боломжтой.',
                  textAlign: TextAlign.center,
                  style: IOStyles.body2Regular,
                ),
                const Spacer(flex: 2),
                IOButtonWidget(
                  onPressed: () => Get.back(result: true),
                  model: IOButtonModel(
                    label: 'Салбарын байршил харах',
                    type: IOButtonType.primary,
                    size: IOButtonSize.medium,
                    isExpanded: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
