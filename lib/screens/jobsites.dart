import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
];

class JobsitesScreen extends StatelessWidget {
  static const routeName = '/jobsites';
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false) {}
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
            return _OpenContainerWrapper(
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return _ExampleCard(openContainer: openContainer);
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

// Card(
//               child: InkWell(
//                 child: ListTile(
//                   title: Text(item.title!),
//                   subtitle: Text(item.address!),
//                 ),
//                 splashColor: Colors.blue.withAlpha(30),
//                 onTap: () {
//                   print('card tapped-------');
//                 },
//               ),
//             );

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
        return const _DetailsPage();
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

class _DetailsPage extends StatelessWidget {
  const _DetailsPage({this.includeMarkAsDoneButton = true});

  final bool includeMarkAsDoneButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details page'),
        actions: <Widget>[
          if (includeMarkAsDoneButton)
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: () => Navigator.pop(context, true),
              tooltip: 'Mark as done',
            )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black38,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(70.0),
              child: Image.asset(
                'assets/placeholder_image.png',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black54,
                        fontSize: 30.0,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  loremIpsumParagraph,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.black54,
                        height: 1.5,
                        fontSize: 16.0,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({required this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    return _InkWellOverlay(
      openContainer: openContainer,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black38,
              child: Center(
                child: Image.asset(
                  'assets/placeholder_image.png',
                  width: 100,
                ),
              ),
            ),
          ),
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Secondary text'),
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
    );
  }
}

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.width,
    this.height,
    this.child,
  });

  final VoidCallback? openContainer;
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}
