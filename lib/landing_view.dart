import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './details_view.dart';

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

  List<Map<dynamic, dynamic>> answers = [
    {
      'voteCount': 2,
    }
  ];

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
            suffixIcon: IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {},
            )));
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

  Widget _buildAnswerCard(BuildContext context, int index) {
    return answers.length > 0
        ? Card(
            child: Row(
            children: <Widget>[
              Container(
                width: 70.0,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    new SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: new IconButton(
                          padding: new EdgeInsets.all(0.0),
                          icon: new Icon(Icons.arrow_drop_up, size: 50.0),
                          onPressed: () {},
                        )),
                    Text('votes'),
                    new SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: new IconButton(
                          padding: new EdgeInsets.all(0.0),
                          icon: new Icon(Icons.arrow_drop_down, size: 50.0),
                          onPressed: () {},
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, '/details', arguments: {'question': 123});
                        Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => 
                      DetailsView(
                        answers[index]['questionDetails']
                      )
                    ));
                      },
                      child: Text('question link here'),
                    ),
                    Text('tags here'),
                    Text('ansers'),
                  ],
                ),
              )
            ],
          ))
        : Center(child: Text('No results found, please refine search'));
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
              child: ListView.builder(
                itemBuilder: _buildAnswerCard,
                itemCount: answers.length,
              ),
            )
          ],
        ));
  }
}
