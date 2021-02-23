import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:reports_manager/models/user.dart';
import 'package:reports_manager/utilities/helpers.dart';
import 'package:reports_manager/utilities/validators.dart';

import '../services/auth.dart';
import 'jobsites.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _registrationData = RegistrationData();
  BuildContext ctx;

  void _submitRegistration() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final errorMsg = await ctx
          .read<AuthService>()
          .registerWithEmailPassword(_registrationData);
      if (errorMsg != null) Helpers.createAlertDialog(ctx, errorMsg);
    }
  }

  Widget _buildRegisterText() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Register',
        style: TextStyle(fontSize: 36.0, color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEmailInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        validator: (value) => Validators.email(value),
        onSaved: (value) => _registrationData.email = value.trim(),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  Widget _buildFirstNameInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        validator: (value) => Validators.name(value, 'First Name'),
        onSaved: (value) => _registrationData.firstName = value.trim(),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: 'First Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  Widget _buildLastNameInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        validator: (value) => Validators.name(value, 'Last Name'),
        onSaved: (value) => _registrationData.lastName = value.trim(),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: 'Last Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _passwordController,
        validator: (value) => Validators.password(value),
        onSaved: (value) => _registrationData.password = value.trim(),
        obscureText: true,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordInput() {
    return Builder(builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          validator: (value) =>
              Validators.passwordMatch(value, _passwordController.text),
          onFieldSubmitted: (_) => _submitRegistration(),
          obscureText: true,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ),
      );
    });
  }

  Widget _buildSignupButton() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () => _submitRegistration(),
        padding: EdgeInsets.all(12),
        color: Colors.lightGreen,
        child: Text('Sign Up'.toUpperCase(),
            style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Padding(
      padding: EdgeInsets.zero,
      child: FlatButton(
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          Navigator.pop(ctx);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    context.watch<AuthService>().user.listen((User user) {
      if (user != null)
        Navigator.pushReplacementNamed(context, JobsitesScreen.routeName);
    });

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildRegisterText(),
                        _buildEmailInput(),
                        _buildFirstNameInput(),
                        _buildLastNameInput(),
                        _buildPasswordInput(),
                        _buildConfirmPasswordInput(),
                        _buildSignupButton(),
                        _buildCancelButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
