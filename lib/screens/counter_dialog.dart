import 'package:flutter/material.dart';

import '../app_config.dart';
import '../models/task_models.dart';

showLoaderVersionAlart(
    BuildContext context, String title, List<Method> methods) {
  var alert = AlertDialog(
    title: Text(
      " ",
      style: Res.textStyleDarkGrey,
    ),
    content: Text("msg"),
    actions: [
      ElevatedButton(
        onPressed: () {},
        child: Text(""),
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
