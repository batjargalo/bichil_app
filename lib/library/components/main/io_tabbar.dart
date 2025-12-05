import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';

class IOTabBar extends PreferredSize {
  final List<String> tabs;

  IOTabBar({
    super.key,
    required this.tabs,
  }) : super(
          preferredSize: const Size.fromHeight(40),
          child: Builder(builder: (context) {
            final tab = DefaultTabController.of(context);
            return MyWidget(tabs: tabs, controller: tab);
          }),
        );
}

class MyWidget extends StatefulWidget {
  final TabController controller;
  final List<String> tabs;
  const MyWidget({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int index = 0;
  double get width =>
      MediaQuery.of(context).size.width / widget.controller.length;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          index = widget.controller.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          left: index * width,
          duration: const Duration(milliseconds: 100),
          child: SizedBox(
            height: 40,
            width: width,
            child: CustomPaint(
              painter: TabPainter(),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: IOColors.brand500,
            unselectedLabelColor: IOColors.backgroundQuarternary,
            indicatorColor: Colors.transparent,
            labelStyle: IOStyles.caption1SemiBold,
            unselectedLabelStyle: IOStyles.caption1SemiBold,
            dividerHeight: 0,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            tabs: widget.tabs.map((e) => Tab(text: e)).toList(),
          ),
        ),
      ],
    );
  }
}

class TabPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final animation = controller.animation!;
    final paint = Paint()..color = IOColors.backgroundSecondary;
    paint.style = PaintingStyle.fill;

    final height = size.height;
    final width = size.width;

    final path = Path()
      ..moveTo(0, height)
      ..quadraticBezierTo(16, height, 16, height - 16)
      ..lineTo(16, 16)
      ..quadraticBezierTo(16, 0, 32, 0)
      ..lineTo(width - 32, 0)
      ..quadraticBezierTo(width - 16, 0, width - 16, 16)
      ..lineTo(width - 16, height - 16)
      ..quadraticBezierTo(width - 16, size.height, width, height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
