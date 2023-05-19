import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackernews/screens/story_detail/controllers/story_detial_controller.dart';
import 'package:hackernews/screens/story_detail/story_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Story {
  static const String type = "story";

  late String by;
  late int? decendants;
  late int id;
  late List<int> kids;
  late int score;
  late int time;
  late String text;
  late String title;
  late String url;

  Story.fromMap(Map data) {
    by = data['by'];
    decendants = data['descendants'];
    id = data['id'];
    kids = data['kids'] == null ? [] : List<int>.from(data['kids']);
    score = data['score'];
    text = data['text'] ?? "";
    time = data['time'];
    title = data['title'] ?? "";
    url = data['url'] ?? "";
  }
  DateTime get exactTime => DateTime.fromMillisecondsSinceEpoch(time);
  Widget toWidget() => _ItemTile(story: this);
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.story,
  });

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 15.h,
        margin: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 1.w),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.24),
            blurRadius: 4,
          )
        ]),
        child: InkWell(
          onTap: () {
            Get.lazyPut(() => StoryDetailController());
            Get.find<StoryDetailController>().loadMore(story);
            Get.to(() => StoryDetailScreen(story: story));
          },
          child: Row(
            children: [
              Container(
                height: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color.fromRGBO(0, 0, 0, 1), Colors.blue],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
                child: Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 16.w,
                ),
              ),
              SizedBox(width: 1.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(1.5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        story.title.capitalize!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        story.text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('dd-MMMM-yyyy').format(story.exactTime),
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.blue),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
