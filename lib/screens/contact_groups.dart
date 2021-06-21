import 'package:flutter/material.dart';

class ContactGroupsScreen extends StatelessWidget {
  static const routeName = '/contact-groups';

  @override
  Widget build(BuildContext context) {
    print('contact group build called-----');
    return Scaffold(
      appBar: AppBar(
        title: Text('Contect Groups'),
      ),
      body: Text('This is the contact groups body'),
    );
  }
}
