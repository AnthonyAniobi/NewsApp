import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:hackernews/screens/homepage/homepage.dart';
import 'package:hackernews/screens/story/story_screen.dart';
import 'package:hackernews/services/app_utils.dart';

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
            menuItem(context, "Home", Icons.house, const Homepage()),
            menuItem(context, "Stories", Icons.newspaper, const StoryScreen()),
            const Spacer(flex: 8),
          ],
        ),
      ),
    );
  }

  Widget menuItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
        size: 30,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        AppUtils.navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (context) => page));
        ZoomDrawer.of(context)?.close();
      },
    );
  }
}
