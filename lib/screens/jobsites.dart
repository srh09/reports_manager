import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports_manager/models/contact_group.dart';
import 'package:reports_manager/screens/contact_group.dart';
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
        final authService = context.read<AuthService>();
        final temp = authService.getUser();
        print('user-------');
        print(temp);
      },
      padding: EdgeInsets.all(12),
      color: Colors.lightGreen,
      child: Text('Test', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobsites'),
        actions: [
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              child: Text('R'),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Options')),
            ListTile(
              title: Text('Jobsites'),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(JobsitesScreen.routeName),
            ),
            ListTile(
              title: Text('Email Groups'),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(ContactGroupsScreen.routeName),
            ),
          ],
        ),
      ),
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
