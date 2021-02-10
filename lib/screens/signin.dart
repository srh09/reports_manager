import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth.dart';
import '../utilities/validators.dart';
import 'signup.dart';
import 'jobsites.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authService.user.listen(
      (User user) {
        if (user != null)
          Navigator.pushReplacementNamed(context, JobsitesScreen.routeName);
      },
    );
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
        controller: emailController,
        validator: (value) => Validators.email(value),
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

  Widget _buildPasswordInput() {
    return SizedBox(
      height: 80.0,
      child: TextFormField(
        controller: passwordController,
        validator: (value) => Validators.password(value),
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) {
          if (_formKey.currentState.validate()) {
            // authService.signInWithEmailPassword(
            //     emailController.text, passwordController.text);
          }
        },
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
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        onPressed: () {
          if (_formKey.currentState.validate())
            authService.signInWithEmailPassword(
                context, emailController.text, passwordController.text);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(SignupScreen.routeName);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightGreen,
        child: Text('Register', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildForgotPasswordLabel() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: FlatButton(
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
                        _buildPasswordInput(),
                        _buildLoginButton(context),
                        _buildRegisterButton(),
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
