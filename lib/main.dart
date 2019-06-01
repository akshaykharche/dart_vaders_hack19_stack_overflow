import 'package:flutter/material.dart';

import './landing_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.orangeAccent,
            //   title: Text('Stack Overflow',),
            // ),
            appBar: AppBar(
            backgroundColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/imageedit_1_4358849406.png',
                  fit: BoxFit.contain,
                  height: 20,
                ),
                Container(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      'Stack Overflow',
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
            body: LandingPage()));
  }
}

class Style {}
