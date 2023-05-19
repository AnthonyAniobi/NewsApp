import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:hackernews/models/comments.dart';
import 'package:hackernews/screens/comment/controllers/comment_controller.dart';
import 'package:hackernews/services/app_extensions.dart';
import 'package:hackernews/widgets/info_text.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key, required this.comment});

  final Comments comment;

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
          comment.by,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoText(title: 'Id', message: comment.id.toString()),
              InfoText(title: 'Parent', message: comment.parent.toString()),
              InfoText(
                  title: 'Time',
                  message:
                      DateFormat('dd MMMM yyyy').format(comment.exactTime)),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Text:  ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: comment.text,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400)),
              ])),
              SizedBox(height: 4.w),
              if (comment.kids.isEmpty)
                Center(
                  child: Text(
                    "No Comments !",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                GetX<CommentController>(builder: (controller) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Comments',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 2.w),
                        ...controller.allComments.map((e) => e.toWidget()),
                        SizedBox(height: 2.w),
                        Center(
                          child: TextButton(
                              onPressed: () {
                                controller.loadMore(comment);
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
                      ]);
                }),
            ],
          ),
        ),
      )),
    );
  }
}
