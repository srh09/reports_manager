import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/jobsite.dart';
import 'contact_group.dart';
import 'signin.dart';
import 'user.dart';
import '../services/auth.dart';

var jobsitesList = [
  Jobsite(title: 'Jobsite Title 1', address: 'jobsite address 1'),
  Jobsite(title: 'Jobsite Title 2', address: 'jobsite address 2'),
];

class JobsitesScreen extends StatelessWidget {
  static const routeName = '/jobsites';

  Widget _buildUserButton(BuildContext context) {
    return PopupMenuButton<UserOptions>(
      onSelected: (UserOptions selection) async {
        print('onselected-----');
        if (selection == UserOptions.UserScreen) {
          print('user screen pushed-----');
          Navigator.of(context).pushNamed(UserScreen.routeName);
        } else if (selection == UserOptions.Logout) {
          await context.read<AuthService>().signOut();
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
    context.watch<AuthService>().user.listen((User? user) {
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
          _UserButton(),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: jobsitesList.length,
          itemBuilder: (context, index) {
            final item = jobsitesList[index];
            return Card(
              child: InkWell(
                child: ListTile(
                  title: Text(item.title!),
                  subtitle: Text(item.address!),
                ),
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('card tapped-------');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _UserButton extends StatelessWidget {
  const _UserButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<UserOptions>(
      onSelected: (UserOptions selection) async {
        print('onselected-----');
        if (selection == UserOptions.UserScreen) {
          print('user screen pushed-----');
          Navigator.of(context).pushNamed(UserScreen.routeName);
        } else if (selection == UserOptions.Logout) {
          await context.read<AuthService>().signOut();
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
}
