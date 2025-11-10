import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class TabBarController extends IOController {
  final tabItems = [
    TabBarModel(icon: 'home.svg', label: 'Нүүр', screen: const HomeScreen()),
    TabBarModel(icon: 'gold.svg', label: 'Алт', screen: const GoldTabScreen()),
    TabBarModel(
      icon: 'money.hand.svg',
      label: 'Зээл',
      screen: const LoanHomeScreen(),
    ),
    TabBarModel(
      icon: 'coin.pig.svg',
      label: 'Итгэлцэл',
      screen: const SavingTabScreen(),
    ),
    TabBarModel(
      icon: 'menu.grid.svg',
      label: 'Цэс',
      screen: const MenuTabScreen(),
    ),
  ];
  final tabIndex = 0.obs;
  final notificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getNotificationCount();
  }

  Future getNotificationCount() async {
    final response = await UserApi().getNotificationCount();
    if (response.isSuccess) {
      notificationCount.value = response.data['unread_count'].integerValue;
    }
  }
}
