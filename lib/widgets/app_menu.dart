import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:hackernews/homepage/homepage.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 40,
                    ),
                    onPressed: () {
                      ZoomDrawer.of(context)!.close();
                      FocusManager.instance.primaryFocus?.unfocus();
                    }),
                const Spacer(flex: 1),
                Text(
                  'Hacker news',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(flex: 3),
              ],
            ),
            const Spacer(),
            menuItem(context, "home", Icons.house, const Homepage()),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }

  Widget menuItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        Get.to(() => page);
        ZoomDrawer.of(context)?.close();
      },
    );
  }
}
