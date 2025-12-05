import 'package:bichil/library/components/image/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBannerSheet extends StatelessWidget {
  final String url;
  const HomeBannerSheet({super.key, required this.url});

  void show() {
    Get.to(() => this, fullscreenDialog: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: IOImageNetworkWidget(
          url: url,
        ),
      ),
    );
  }
}
