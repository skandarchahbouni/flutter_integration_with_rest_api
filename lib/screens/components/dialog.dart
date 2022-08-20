import 'package:flutter/material.dart';

showAlertDialog(BuildContext context,
    {required handleConfirm, required String title, required String body}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(body),
    actions: [
      ElevatedButton(
        child: const Text("Confirm"),
        onPressed: handleConfirm,
      ),
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"))
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

