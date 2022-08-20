import 'package:flutter/material.dart';

showSuccessDialog(BuildContext context,
    {required String? title, required String? body}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title ?? ""),
    content: Text(body ?? ""),
    backgroundColor: Colors.green,
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
