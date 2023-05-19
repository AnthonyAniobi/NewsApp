import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:hackernews/screens/story/controllers/story_controller.dart';
import 'package:hackernews/services/app_enums.dart';
import 'package:hackernews/services/app_extensions.dart';
import 'package:hackernews/widgets/shimmer_list_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  StoryType selectedType = StoryType.top;

  // constant
  int storiesPerPage = 20; // number of stories in a page

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => StoryController());
    Get.find<StoryController>().getData(selectedType);
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
          "Stories",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: GetX<StoryController>(builder: (controller) {
        return SafeArea(
          child: Stack(children: [
            controller.isLoading.value
                ? ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) =>
                        const ShimmerListTile(hasImage: true))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...StoryType.values.map((sT) => _tabButton(sT))
                          ],
                        ),
                      ),
                      SizedBox(height: 2.w),
                      Expanded(
                          child: ListView.builder(
                              itemCount:
                                  controller.listItems(selectedType).length,
                              itemBuilder: (context, index) {
                                return controller
                                        .listItems(selectedType)[index]
                                        .isLeft
                                    ? const ShimmerListTile(hasImage: true)
                                    : controller
                                        .listItems(selectedType)[index]
                                        .right
                                        .toWidget();
                              })),
                    ],
                  ),
            // Align(
            //     alignment: Alignment.bottomCenter,
            //     child: PageListTile(length: 8, onTap: (value) {}))
          ]),
        );
      }),
    );
  }

  InkWell _tabButton(StoryType type) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedType = type;
          Get.find<StoryController>().loadDetails(type);
        });
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
              color: type != selectedType ? Colors.grey : Colors.blue),
          alignment: Alignment.center,
          width: 15.h,
          child: Text(
            type.name,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
