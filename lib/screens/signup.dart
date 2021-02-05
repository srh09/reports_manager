import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth.dart';
import 'jobsites.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final emailTextEditController = TextEditingController();
  final firstNameTextEditController = TextEditingController();
  final lastNameTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();
  final confirmPasswordTextEditController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  var _errorMessage = '';

  @override
  void initState() {
    super.initState();
    authService.user.listen(
      (User user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, JobsitesScreen.routeName);
        }
      },
    );
  }

  void processError(final PlatformException error) {
    setState(() {
      _errorMessage = error.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 36.0, left: 24.0, right: 24.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 36.0, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '$_errorMessage',
                  style: TextStyle(fontSize: 14.0, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email.';
                    }
                    return null;
                  },
                  controller: emailTextEditController,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  focusNode: _emailFocus,
                  onFieldSubmitted: (term) {
                    FocusScope.of(context).requestFocus(_firstNameFocus);
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your first name.';
                    }
                    return null;
                  },
                  controller: firstNameTextEditController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  focusNode: _firstNameFocus,
                  onFieldSubmitted: (term) {
                    FocusScope.of(context).requestFocus(_lastNameFocus);
                  },
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your last name.';
                    }
                    return null;
                  },
                  controller: lastNameTextEditController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  focusNode: _lastNameFocus,
                  onFieldSubmitted: (term) {
                    FocusScope.of(context).requestFocus(_passwordFocus);
                  },
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.length < 8) {
                      return 'Password must be longer than 8 characters.';
                    }
                    return null;
                  },
                  autofocus: false,
                  obscureText: true,
                  controller: passwordTextEditController,
                  textInputAction: TextInputAction.next,
                  focusNode: _passwordFocus,
                  onFieldSubmitted: (term) {
                    FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  controller: confirmPasswordTextEditController,
                  focusNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (passwordTextEditController.text.length > 8 &&
                        passwordTextEditController.text != value) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      authService.registerWithEmailPassword(
                          emailTextEditController.text,
                          passwordTextEditController.text);
                    }
                  },
                  padding: EdgeInsets.all(12),
                  color: Colors.lightGreen,
                  child: Text('Sign Up'.toUpperCase(),
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                  padding: EdgeInsets.zero,
                  child: FlatButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black54),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
