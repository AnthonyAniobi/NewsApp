import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PollOpt {
  static const String type = "pollopt";

  late String by;
  late int id;
  late int poll;
  late int score;
  late String text;
  late int time;

  PollOpt.fromMap(Map data) {
    by = data['by'];
    id = data['id'];
    poll = data['poll'];
    score = data['score'];
    text = data['text'];
    time = data['time'];
  }
  DateTime get exactTime => DateTime.fromMillisecondsSinceEpoch(time);
  Widget toWidget() => _ItemTile(poll: this);
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.poll,
  });

  final PollOpt poll;

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
                Icons.bar_chart,
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
                      poll.text,
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
                          DateFormat('dd-MMMM-yyyy').format(poll.exactTime),
                          style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
