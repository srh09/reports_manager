import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports_manager/screens/contact_groups.dart';
import 'package:reports_manager/screens/jobsites.dart';
import 'package:reports_manager/screens/report.dart';
import 'package:reports_manager/screens/signup.dart';
import 'package:reports_manager/screens/user.dart';
import 'package:reports_manager/services/auth.dart';

import 'screens/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AppShell(),
        routes: {
          SigninScreen.routeName: (context) => SigninScreen(),
          SignupScreen.routeName: (context) => SignupScreen(),
          UserScreen.routeName: (context) => UserScreen(),
          JobsitesScreen.routeName: (context) => JobsitesScreen(),
          ContactGroupsScreen.routeName: (context) => ContactGroupsScreen(),
          ReportScreen.routeName: (context) => ReportScreen(),
        },
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({Key? key}) : super(key: key);
  static const routeName = '/shell';

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  var _currentIndex = 1;
  final _screenList = [
    ContactGroupsScreen(),
    JobsitesScreen(),
    ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    print('build called on appShell-----');
    return Scaffold(
      body: PageTransitionSwitcher(
        child: _screenList[_currentIndex],
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
      ),
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: _screenList,
      // ),
      // body: _screenList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.email_outlined),
            label: 'Email Groups',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.my_location_rounded),
            label: 'Jobsites',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined),
            label: 'Reports',
          )
        ],
      ),
    );
  }
}
