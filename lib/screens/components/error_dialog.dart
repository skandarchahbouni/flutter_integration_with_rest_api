
import 'package:flutter/material.dart';

showErrorDialog(BuildContext context,
    {required String title, required String body}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(body),
    backgroundColor: Colors.red[500],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
