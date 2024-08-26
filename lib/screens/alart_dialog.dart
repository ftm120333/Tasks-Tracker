import 'package:flutter/material.dart';

import '../app_config.dart';

showLoaderVersionAlart(
    BuildContext context, String title, String msg, onConfirm) {
  var alert = AlertDialog(
    title: Text(
      title,
      style: Res.textStyleBoldDarkGrey,
    ),
    content: Text(
      msg,
      style: Res.textStyleDarkGrey,
    ),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Res.kPrimaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          onConfirm();
          Navigator.pop(context);
        },
        child: Text("ok"),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Res.kPrimaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("cancel"),
      ),
    ],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
