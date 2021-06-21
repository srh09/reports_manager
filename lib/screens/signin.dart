import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:reports_manager/main.dart';

import '../models/auth.dart';
import '../utilities/helpers.dart';
import '../services/auth.dart';
import '../utilities/validators.dart';
import 'signup.dart';
import 'jobsites.dart';

class SigninScreen extends StatelessWidget {
  static const routeName = '/signin';
  final _formKey = GlobalKey<FormState>();
  final _signinData = SigninData();

  void _submitSignIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final errorMsg = await context
          .read<AuthService>()
          .signInWithEmailPassword(_signinData);
      if (errorMsg != null) Helpers.createAlertDialog(context, errorMsg);
    }
  }

  Widget _buildHeroLogo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          // child: Image.asset('assets/logo.png'),
          child: FlutterLogo(
            size: 100,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        validator: (value) => Validators.email(value),
        onSaved: (value) => _signinData.email = value!.trim(),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: TextFormField(
        validator: (value) => Validators.password(value),
        onSaved: (value) => _signinData.password = value!.trim(),
        onFieldSubmitted: (_) => _submitSignIn(context),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _submitSignIn(context),
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(SignupScreen.routeName),
        child: Text('Register', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildForgotPasswordLabel() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: TextButton(
        child: Text(
          'Forgot password?',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AuthService>().user.listen((User? user) {
      if (user != null)
        Navigator.pushReplacementNamed(context, AppShell.routeName);
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
                        _buildHeroLogo(),
                        _buildEmailInput(),
                        _buildPasswordInput(context),
                        _buildLoginButton(context),
                        _buildRegisterButton(context),
                        _buildForgotPasswordLabel(),
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
