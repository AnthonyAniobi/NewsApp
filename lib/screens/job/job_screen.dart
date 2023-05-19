import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hackernews/models/job.dart';
import 'package:hackernews/widgets/info_text.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key, required this.job});

  final Job job;

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
          job.by,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoText(title: 'Id', message: job.id.toString()),
            InfoText(title: 'Score', message: job.score.toString()),
            InfoText(
                title: 'Time',
                message: DateFormat('dd MMMM yyyy').format(job.exactTime)),
            InfoText(title: 'Url', message: job.url ?? ""),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Title:  ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: job.title,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400)),
            ])),
            SizedBox(height: 2.w),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Text:  ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: job.text,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400)),
            ])),
            SizedBox(height: 4.w),
          ],
        ),
      )),
    );
  }
}
