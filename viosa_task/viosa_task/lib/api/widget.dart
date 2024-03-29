import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future? apiDialog(String msg) {
  return Get.dialog(
    barrierDismissible: false,
    CupertinoAlertDialog(
      title: Text(msg),
      actions: [
        CupertinoActionSheetAction(
          child: Text('Ok'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    ),
  );
}