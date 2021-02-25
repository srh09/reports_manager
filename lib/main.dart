import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports_manager/screens/contact_group.dart';
import 'package:reports_manager/screens/jobsites.dart';
import 'package:reports_manager/screens/report.dart';
import 'package:reports_manager/screens/signup.dart';
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
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().user,
        )
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
