import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InfoText extends StatelessWidget {
  const InfoText({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
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
}
