import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingPageState();
  }
}

 class _LandingPageState extends State<LandingPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final textController = TextEditingController();
  var data;
  FocusNode focusOnSearch = FocusNode();

  void submit() {
    _formKey.currentState.save();
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "https://api.stackexchange.com/2.2/search/advanced?key=U4DMV*8nvpm3EOpvf69Rxw((&site=stackoverflow&order=desc&sort=activity&user=anuradha&filter=default"),
        headers: {"Accept": "application/json"});
    data = jsonDecode(response.body);
  }

  _buildSearchInputField() {
    return TextFormField(
        controller: textController,
        focusNode: focusOnSearch,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a question to search.';
          }
        },
        onFieldSubmitted: (value) {
          // FocusScope.of(context).requestFocus(focusOn);
        },
        decoration: InputDecoration(
            hintText: 'your question here',
            labelText: 'question',
            suffixIcon: Icon(Icons.mic)));
  }

  _buildTags() {
    return Row(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            // api call to get newest questions
          },
          child: Text(
            'Newest',
          ),
        ),
        RaisedButton(
          onPressed: () {
            // api call to get ananswered questions
          },
          child: Text('Unanswered'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            _buildTags(),
            Row(
              children: <Widget>[Text('Answers below'), Icon(Icons.search)],
            ),
            _buildSearchInputField(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.arrow_upward),
                        Icon(Icons.arrow_downward)
                      ],
                    ),
                  ),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Container(
                  //         height: 200.0,
                  //         margin: EdgeInsets.all(10.0),
                  //         decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.black12)),
                  //         child: Column(
                  //           children: <Widget>[
                  //             Icon(Icons.arrow_upward),
                  //             Icon(Icons.arrow_downward)
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ));
  }
}
