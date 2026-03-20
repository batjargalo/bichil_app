import 'package:bichil/screens/screens.dart';

class QpayDanScreenModel {
  final String title;
  final String invoice;
  final List<QpayDanModel> urls;
  final List<QpayDanInfoModel> info;

  QpayDanScreenModel({
    required this.title,
    required this.invoice,
    required this.info,
    required this.urls,
  });
}

class QpayDanInfoModel {
  final String title;
  final String value;

  QpayDanInfoModel({required this.title, required this.value});
}
