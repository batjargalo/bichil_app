import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';

class NotificationPageScreen extends StatelessWidget {
  const NotificationPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: IOScaffold(
        appBar: IOAppBar(
          hasCorner: false,
          titleText: 'Шуудан',
          bottom: IOTabBar(
            tabs: const ['Мэдэгдэл', 'Мэдээ'],
          ),
        ),
        body: const TabBarView(children: [
          NotificationListScreen(type: NotificationType.private),
          NotificationListScreen(type: NotificationType.news),
        ]),
      ),
    );
  }
}
