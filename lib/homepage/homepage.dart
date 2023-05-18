import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            ZoomDrawer.of(context)?.open();
          },
        ),
        title: Text(
          "Hacker News",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
