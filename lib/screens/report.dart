import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  static const routeName = '/report';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report')),
      body: Text('This is the body of the Report'),
    );
  }
}
