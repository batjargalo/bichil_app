import 'package:bichil/library/library.dart';
import 'package:bichil/main_config.dart';
import 'package:bichil/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainConfig.setOrientationConfig();
  await MainConfig.setStoreConfig();
  await MainConfig.setFirebaseConfig();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(MainController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => controller.onEventChanged(),
      child: GetMaterialApp(
        title: 'Bichil',
        theme: IOTheme.lightTheme,
        getPages: IOPages.pages,
        initialRoute: IOPages.initial,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
