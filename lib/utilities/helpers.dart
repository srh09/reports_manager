import 'package:flutter/material.dart';

class Helpers {
  static void createAlertDialog(BuildContext context, String message,
      [String title]) {
    Widget okButton = FlatButton(
      child: Text('OK'),
      onPressed: () {},
    );

    AlertDialog alertDialog = AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
    );
  }
}
