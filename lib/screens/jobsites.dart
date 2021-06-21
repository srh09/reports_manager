import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports_manager/screens/jobsite.dart';
import 'package:reports_manager/utilities/constants.dart';

import '../models/auth.dart';
import '../models/jobsite.dart';
import 'contact_group.dart';
import 'signin.dart';
import 'user.dart';
import '../services/auth.dart';

var jobsitesList = [
  Jobsite(title: 'Jobsite Title 1', address: 'jobsite address 1'),
  Jobsite(title: 'Jobsite Title 2', address: 'jobsite address 2'),
  Jobsite(title: 'Jobsite Title3', address: 'jobsite address 3'),
];

class JobsitesScreen extends StatelessWidget {
  static const routeName = '/jobsites';
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false) {}
  }

  @override
  Widget build(BuildContext context) {
    print('jobsites build called----');
    context.watch<AuthService>().user.listen((User? user) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: jobsitesList.length,
          itemBuilder: (context, index) {
            final jobsite = jobsitesList[index];
            return _OpenContainerWrapper(
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return _JobsiteCard(jobsite, openContainer);
              },
              transitionType: _transitionType,
              onClosed: _showMarkedAsDoneSnackbar,
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
        if (selection == UserOptions.UserScreen) {
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

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return const JobsiteScreen();
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

class _JobsiteCard extends StatelessWidget {
  const _JobsiteCard(this.jobsite, this.openContainer);

  final Jobsite jobsite;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: InkWell(
        onTap: openContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.black38,
                child: Center(
                  child: FlutterLogo(
                    size: 100,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(jobsite.title),
              subtitle: Text(jobsite.address),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur '
                'adipiscing elit, sed do eiusmod tempor.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
