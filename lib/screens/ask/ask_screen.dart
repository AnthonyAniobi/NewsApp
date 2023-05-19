import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:hackernews/models/ask.dart';
import 'package:hackernews/screens/ask/controllers/ask_controller.dart';
import 'package:hackernews/services/app_extensions.dart';
import 'package:hackernews/widgets/info_text.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AskScreen extends StatelessWidget {
  const AskScreen({super.key, required this.ask});

  final Ask ask;

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
          ask.by,
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
              InfoText(title: 'Id', message: ask.id.toString()),
              InfoText(title: 'Score', message: ask.score.toString()),
              InfoText(
                  title: 'Time',
                  message: DateFormat('dd MMMM yyyy').format(ask.exactTime)),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Text:  ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: ask.text,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400)),
              ])),
              SizedBox(height: 4.w),
              if (ask.kids.isEmpty)
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
                GetX<AskController>(builder: (controller) {
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
                                controller.loadMore(ask);
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
