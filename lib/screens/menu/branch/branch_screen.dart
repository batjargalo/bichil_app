import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchScreen extends GetView<BranchController> {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: IOScaffold(
        appBar: IOAppBar(
          hasCorner: false,
          titleText: 'Салбар',
          bottom: IOTabBar(
            tabs: const [
              'Жагсаалт',
              'Газрын зураг',
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            BranchListScreen(),
            BranchMapScreen(),
          ],
        ),
      ),
    );
  }
}
