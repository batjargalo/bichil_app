import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:g_json/g_json.dart';

class DynamicRoute {
  static void onNotification(NotificationResponse detail) {
    final data = JSON.parse(detail.payload ?? '');
    handleAction(data);
  }

  static void handleAction(JSON data) {
    final action = data['action'].stringValue;
    // final id = data['action_id'].integerValue;
    // final url = data['url'].stringValue;

    switch (action) {
      case 'loan_history':
        // LoanRoute.toDetail(loan: loan);
        break;
      //   case 'banner':
      //     final bannerList = Get.find<HomeController>().promoBannerItems;
      //     int index = bannerList.indexWhere((e) => e.id == id);
      //     if (index == -1) {
      //       index = 0;
      //     }
      //     AppRoute.toPromoBanner(items: bannerList, index: index);
      //     break;
      //   case 'mission':
      //     break;
      //   case 'purchase':
      //     final jumpToFeedback = data['jump_feedback'].booleanValue;
      //     if (jumpToFeedback) {
      //       AppRoute.toRatingPoint(id: id);
      //     } else {
      //       MenuRoute.toPurchaseHistory();
      //     }
      //     break;
      //   case 'url':
      //     MenuRoute.toWebview(
      //       title: data['title'].stringValue,
      //       url: url,
      //     );
      //     break;
      default:
        break;
    }
  }
}
