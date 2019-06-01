import 'package:flutter/material.dart';

import './landing_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title: Text(
              'Stack Overflow',
            ),
          ),
          body: LandingPage(),
        ),
        );
  }
}
