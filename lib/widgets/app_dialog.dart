import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  static Future<bool> yesOrNo(String title, String content,
      {String yesText = "Yes", String noText = "No"}) async {
    return await Get.dialog<bool?>(AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: Text(noText)),
            ElevatedButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: Text(yesText))
          ],
        )) ??
        false;
  }

  static Future<void> basic(String title, String content,
      {String cancelText = "Cancel"}) async {
    await Get.dialog<bool?>(AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text(cancelText))
      ],
    ));
  }
}
