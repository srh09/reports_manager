import 'package:flutter/material.dart';
import 'package:reports_manager/screens/contact_group.dart';
import 'package:reports_manager/screens/jobsites.dart';
import 'package:reports_manager/screens/report.dart';
import 'package:reports_manager/screens/signup.dart';

import 'screens/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SigninScreen(),
      routes: {
        SigninScreen.routeName: (context) => SigninScreen(),
        SignupScreen.routeName: (context) => SignupScreen(),
        JobsitesScreen.routeName: (context) => JobsitesScreen(),
        ContactGroupsScreen.routeName: (context) => ContactGroupsScreen(),
        ReportScreen.routeName: (context) => ReportScreen(),
      },
    );
  }
}
