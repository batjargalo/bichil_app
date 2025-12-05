import 'package:bichil/screens/screens.dart';

class QpayScreenModel {
  final String title;
  final String invoice;
  final List<QpayModel> urls;
  final List<QpayInfoModel> info;

  QpayScreenModel({
    required this.title,
    required this.invoice,
    required this.info,
    required this.urls,
  });
}

class QpayInfoModel {
  final String title;
  final String value;

  QpayInfoModel({
    required this.title,
    required this.value,
  });
}
