import 'package:bichil/library/library.dart';
import 'package:bichil/screens/menu/change_relate/sheets/relate_sheet.dart';
import 'package:flutter/material.dart';

List<RelatedModel> relations = [
  RelatedModel(value: "1", relation: 'Эцэг/эх/'),
  RelatedModel(value: "1", relation: 'Эцэг/эх/'),
  RelatedModel(value: "2", relation: 'Ах/эгч/'),
  RelatedModel(value: "3", relation: 'Нөхөр/эхнэр/'),
  RelatedModel(value: "4", relation: 'Хүү/охин/'),
  RelatedModel(value: "5", relation: 'Найз'),
  RelatedModel(value: "6", relation: 'Бусад'),
];

class UserRelatedInfoWidget extends StatelessWidget {
  final String relation;
  final String name;
  final String phone;
  final bool hasAction;
  final VoidCallback? onTap;
  const UserRelatedInfoWidget({
    super.key,
    required this.relation,
    required this.name,
    required this.phone,
    this.hasAction = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  relations
                      .firstWhere(
                        (r) => r.value == relation,
                        orElse: () => RelatedModel(value: "", relation: ""),
                      )
                      .relation,
                  style: IOStyles.body2Regular.copyWith(
                    color: IOColors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Нэр: ",
                      style: IOStyles.body2Regular.copyWith(
                        color: IOColors.textSecondary,
                      ),
                    ),
                    Text(
                      name.isEmpty ? '-' : name,
                      style: IOStyles.body2Semibold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Утас: ",
                      style: IOStyles.body2Regular.copyWith(
                        color: IOColors.textSecondary,
                      ),
                    ),
                    Text(
                      phone.isEmpty ? '-' : phone,
                      style: IOStyles.body2Semibold,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (hasAction)
            GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    name.isEmpty ? 'Оруулах' : 'Солих',
                    style: IOStyles.button40.copyWith(color: IOColors.brand500),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
