import 'package:flutter/material.dart';
import 'package:hackernews/homepage/homepage.dart';
import 'package:hackernews/widgets/app_background_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) => AppDrawerBackground(child: child!),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}
