import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Future getData() async {
    http.Response response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    List data = jsonDecode(response.body);
    print(data[1]['title']);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title: Text('Stack Overflow'),
          ),
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      // api call to get newest questions
                    },
                    child: Text('Newest'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // api call to get ananswered questions
                    },
                    child: Text('Unanswered'),
                  ),
                ],
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Text('Questions')
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
