import 'package:flutter/material.dart';

import '../utilities/validators.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: SingleChildScrollView(
        child: TextFormField(
          initialValue: '',
          validator: (value) => Validators.name(value, 'First Name'),
          onSaved: (value) => {},
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
