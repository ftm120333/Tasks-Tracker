import 'package:flutter/material.dart';

import '../app_config.dart';

showLoaderVersionAlart(
    BuildContext context, String title, String msg, onConfirm) {
  var alert = AlertDialog(
    title: Text(
      title,
      style: Res.textStyleDarkGrey,
    ),
    content: Text(msg),
    actions: [
      ElevatedButton(
        onPressed: () {
          onConfirm();
          Navigator.pop(context);
        },
        child: Text("ok"),
      ),
      ElevatedButton(
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
