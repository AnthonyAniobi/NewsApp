import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hackernews/models/pollopt.dart';
import 'package:hackernews/widgets/info_text.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PollOptScreen extends StatelessWidget {
  const PollOptScreen({super.key, required this.pollopt});

  final PollOpt pollopt;

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
          pollopt.by,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoText(title: 'Id', message: pollopt.id.toString()),
            InfoText(title: 'Score', message: pollopt.score.toString()),
            InfoText(title: 'poll', message: pollopt.poll.toString()),
            InfoText(
                title: 'Time',
                message: DateFormat('dd MMMM yyyy').format(pollopt.exactTime)),
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
                  text: pollopt.text,
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
