import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:hackernews/screens/user/controllers/user_controller.dart';
import 'package:hackernews/services/app_extensions.dart';
import 'package:hackernews/widgets/shimmer_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, required this.userId});
  final String userId;
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => UserController());
    Get.find<UserController>().loadUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(builder: (controller) {
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
              controller.user.value?.id ?? "",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: controller.isLoading.value
              ? loadingScreen()
              : SafeArea(
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.w),
                      titleInfo(
                          'Created',
                          DateFormat('dd MMMM yyyy')
                              .format(controller.user.value!.exactTime)),
                      SizedBox(height: 2.w),
                      titleInfo('Delay',
                          controller.user.value?.delay.toString() ?? ""),
                      SizedBox(height: 2.w),
                      titleInfo('Karma',
                          controller.user.value?.karma.toString() ?? ""),
                      SizedBox(height: 2.w),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'About:  ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: controller.user.value?.about ?? "",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400)),
                      ])),
                      SizedBox(height: 4.w),
                      Text('Submitted',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 2.w),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Column(children: [
                        ...controller.submitted.map((e) => e.toWidget()),
                        SizedBox(height: 2.w),
                        Center(
                          child: TextButton(
                              onPressed: () {
                                controller.loadMore();
                              },
                              child: Text(
                                "Load More",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18.sp,
                                    decoration: TextDecoration.underline),
                              )),
                        ),
                        SizedBox(height: 4.w),
                      ]))),
                    ],
                  ),
                )));
    });
  }

  Widget titleInfo(String title, String message) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '$title:  ',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold)),
      TextSpan(
          text: message, style: TextStyle(fontSize: 16.sp, color: Colors.blue)),
    ]));
  }

  Widget loadingScreen() {
    return ListView(children: [
      const ShimmerListTile(),
      SizedBox(height: 2.w),
      ...List.generate(10, (index) => index)
          .map((e) => const ShimmerListTile(hasImage: true)),
    ]);
  }
}
