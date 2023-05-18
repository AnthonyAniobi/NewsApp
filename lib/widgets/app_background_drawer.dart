import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:hackernews/widgets/app_dialog.dart';
import 'package:hackernews/widgets/app_menu.dart';

class AppDrawerBackground extends StatefulWidget {
  const AppDrawerBackground({super.key, required this.child});
  final Widget child;

  @override
  State<AppDrawerBackground> createState() => _AppDrawerBackgroundState();
}

class _AppDrawerBackgroundState extends State<AppDrawerBackground> {
  Future<bool> _willPop(BuildContext context) async {
    return await AppDialog.yesOrNo(
        "Warning ℹ️", "You are about to close application");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: ZoomDrawer(
        menuScreenWidth: MediaQuery.of(context).size.width,
        moveMenuScreen: false,
        showShadow: true,
        menuScreen: const AppMenu(),
        mainScreen: Column(
          children: [
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
