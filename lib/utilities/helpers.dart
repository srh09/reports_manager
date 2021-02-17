import 'package:flutter/material.dart';

class Helpers {
  static void createAlertDialog(BuildContext context, String message,
      [String title]) {
    Widget okButton = TextButton(
      child: Text('OK'),
      onPressed: () => Navigator.pop(context),
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        primary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: [okButton],
      elevation: 24.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );

    showDialog(
      context: context,
      builder: (_) => alertDialog,
    );
  }
}
