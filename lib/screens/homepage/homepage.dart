import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:hackernews/models/ask.dart';
import 'package:hackernews/models/comments.dart';
import 'package:hackernews/models/job.dart';
import 'package:hackernews/models/poll.dart';
import 'package:hackernews/models/story.dart';
import 'package:hackernews/screens/homepage/controllers/update_controller.dart';
import 'package:hackernews/screens/user/user_screen.dart';
import 'package:hackernews/services/app_extensions.dart';
import 'package:hackernews/widgets/shimmer_avatar.dart';
import 'package:hackernews/widgets/shimmer_list_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => UpdateController());
    Get.find<UpdateController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: GetX<UpdateController>(builder: (controller) {
        if (controller.isLoading.isTrue) {
          return loaderWidget();
        }
        if (controller.items.isEmpty) {
          return emptyData();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              child: Text(
                "Profiles: ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                height: 13.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.profiles.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        width: 12.h,
                        child: InkWell(
                          onTap: () {
                            Get.to(() =>
                                UserScreen(userId: controller.profiles[index]));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 8.h,
                                width: 8.h,
                                padding: EdgeInsets.all(2.h),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(0, 0, 0, 1),
                                          Colors.blue
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter)),
                                child: FittedBox(
                                  child: Text(
                                    controller.profiles[index]
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: double.maxFinite,
                                  child: Expanded(
                                      child: Text(
                                    controller.profiles[index],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ))),
                            ],
                          ),
                        ),
                      );
                    })),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              child: Text(
                "Updates: ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      return controller.items[index].isLeft
                          ? const ShimmerListTile(hasImage: true)
                          : controller.items[index].right.toWidget();
                    }))
          ],
        );
      }),
    );
  }

  Column loaderWidget() {
    return Column(
      children: [
        SizedBox(height: 2.h),
        SizedBox(
          height: 11.h,
          child: ListView.builder(
              padding: EdgeInsets.only(left: 2.w),
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const ShimmerAvatar();
              }),
        ),
        SizedBox(height: 2.h),
        Expanded(
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) =>
                  const ShimmerListTile(hasImage: true)),
        ),
      ],
    );
  }

  Widget emptyData() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Couldn't fetch data, Check your connection and try again",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 2.w, width: double.maxFinite),
        ElevatedButton(
          onPressed: () async {
            await Get.find<UpdateController>().refreshData();
          },
          child: const Text("Refresh Data"),
        )
      ],
    ));
  }
}
