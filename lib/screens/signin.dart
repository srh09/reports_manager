import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'signup.dart';
import '../services/auth.dart';
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

  void resetErrorMsg() {
    setState(() => _errorMessage = '');
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    emailController.addListener(resetErrorMsg);
    passwordController.addListener(resetErrorMsg);

    Widget _buildHeroLogo() {
      return Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          // child: Image.asset('assets/logo.png'),
          child: FlutterLogo(
            size: 100,
          ),
        ),
      );
    }

    Widget _buildErrorDisplay() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
        child: Text(
          '$_errorMessage',
          style: TextStyle(fontSize: 14.0, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    Widget _buildEmailInput() {
      return TextFormField(
        validator: (value) {
          if (value.isEmpty || !value.contains('@')) {
            return 'Please enter a valid email.';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
      );
    }

    Widget _buildPasswordInput() {
      return TextFormField(
        autofocus: false,
        obscureText: true,
        controller: passwordController,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(node);
        },
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );
    }

    Widget _buildLoginButton() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              authService.signInWithEmailPassword(
                  emailController.text, passwordController.text);
            }
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    Widget _buildRegisterButton() {
      return Padding(
        padding: EdgeInsets.zero,
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
      return FlatButton(
        child: Text(
          'Forgot password?',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {},
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            children: <Widget>[
              _buildHeroLogo(),
              _buildErrorDisplay(),
              _buildEmailInput(),
              _buildPasswordInput(),
              _buildLoginButton(),
              _buildRegisterButton(),
              _buildForgotPasswordLabel(),
            ],
          ),
        ),
      ),
    );
  }

  void processError(final PlatformException error) {
    if (error.code == "ERROR_USER_NOT_FOUND") {
      setState(() {
        _errorMessage = "Unable to find user. Please register.";
      });
    } else if (error.code == "ERROR_WRONG_PASSWORD") {
      setState(() {
        _errorMessage = "Incorrect password.";
      });
    } else {
      setState(() {
        _errorMessage =
            "There was an error logging in. Please try again later.";
      });
    }
  }
}
