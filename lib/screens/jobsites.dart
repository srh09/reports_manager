import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports_manager/models/auth.dart';
import 'package:reports_manager/models/contact_group.dart';
import 'package:reports_manager/screens/contact_group.dart';
import 'package:reports_manager/screens/signin.dart';
import 'package:reports_manager/screens/user.dart';
import 'package:reports_manager/services/auth.dart';

class JobsitesScreen extends StatelessWidget {
  static const routeName = '/jobsites';

  Widget _buildUserButton(BuildContext context) {
    return PopupMenuButton<UserOptions>(
      onSelected: (UserOptions selection) {
        print('onselected-----');
        if (selection == UserOptions.UserScreen) {
          print('user screen pushed-----');
          Navigator.of(context).pushNamed(UserScreen.routeName);
        } else if (selection == UserOptions.Logout) {
          // logout
        }
      },
      icon: Icon(Icons.person),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('Profile'),
          value: UserOptions.UserScreen,
        ),
        PopupMenuItem(
          child: Text('Logout'),
          value: UserOptions.Logout,
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () async {
        print('logout started----');
        await context.read<AuthService>().signOut();
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   SigninScreen.routeName,
        //   (Route<dynamic> route) => false,
        // );
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
        print('about to test------');
        final test = Provider.of<AuthService>(context, listen: false).user;
        print(test);
        final authService = context.read<AuthService>();
        final temp = authService.getUser();
        // print('user-------');
        // print(temp);
      },
      padding: EdgeInsets.all(12),
      color: Colors.lightGreen,
      child: Text('Test', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AuthService>().user.listen((User user) {
      print('triggered-----');
      print(user);
      if (user == null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          SigninScreen.routeName,
          (Route<dynamic> route) => false,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Jobsites'),
        actions: [
          _buildUserButton(context),
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
