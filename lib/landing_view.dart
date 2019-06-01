import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './details_view.dart';
import './votes.dart';

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

  List answers = [{}];

  void submit() {
    _formKey.currentState.save();
  }

  Future<http.Response> getQuestions() {
    String url =
        'https://api.stackexchange.com/2.2/search/advanced?key=U4DMV*8nvpm3EOpvf69Rxw((&site=stackoverflow&order=desc&sort=activity&user=anuradha&filter=default';
    return http.get(url);
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
    var tagCount = answers[index]["score"];
    var answerCount = answers[index]["answer_count"];
    var viewCount = answers[index]["view_count"];

    return Card(
        child: Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      '$tagCount vote(s)',
                      style: TextStyle(fontSize: 12.0, color: Colors.black54),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      '$answerCount answer(s)',
                      style: TextStyle(fontSize: 12.0, color: Colors.black54),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      '$viewCount view(s)',
                      style: TextStyle(fontSize: 12.0, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DetailsView(answers[index]['questionDetails'])));
                },
                child: Text(answers[index]['title']),
              ),
              RaisedButton(
                child: Text(
                  answers[index]['tags'][0],
                ),
                onPressed: () {},
              )
            ],
          ),
        )
      ],
    ));
  }

  Widget _buildBodyWithSpinner(BuildContext context) {
    return StreamBuilder(
      stream: getQuestions().asStream(),
      builder: (BuildContext context, response) {
        return response.hasData
            ? _buildBody(context, json.decode(response.data.body)['items'])
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildBody(BuildContext context, List questionsData) {
    answers = questionsData;

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
                itemBuilder: _buildAnswerCard, // _buildAnswerCard,
                itemCount: answers.length,
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWithSpinner(context);
  }
}
