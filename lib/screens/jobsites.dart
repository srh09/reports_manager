import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports_manager/screens/signin.dart';
import 'package:reports_manager/services/auth.dart';

class JobsitesScreen extends StatelessWidget {
  static const routeName = '/jobsites';

  Widget _buildLogoutButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () async {
        await context.read<AuthService>().signOut();
        Navigator.of(context).pushNamedAndRemoveUntil(
          SigninScreen.routeName,
          (Route<dynamic> route) => false,
        );
      },
      padding: EdgeInsets.all(12),
      color: Colors.lightGreen,
      child: Text('Logout', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildTestButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        final service = context.read<AuthService>();
        print('user-------');
        print(service.user);
      },
      padding: EdgeInsets.all(12),
      color: Colors.lightGreen,
      child: Text('Test', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jobsites')),
      body: Center(
        child: Column(
          children: [
            _buildLogoutButton(context),
            _buildTestButton(context),
          ],
        ),
      ),
    );
  }
}
