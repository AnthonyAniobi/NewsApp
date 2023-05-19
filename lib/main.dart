import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackernews/screens/homepage/homepage.dart';
import 'package:hackernews/services/app_utils.dart';
import 'package:hackernews/widgets/app_background_drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'Hacker news',
        navigatorKey: AppUtils.navigatorKey,
        builder: (context, child) => AppDrawerBackground(child: child!),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Homepage(),
      );
    });
  }
}
