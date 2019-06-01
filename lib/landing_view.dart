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
  FocusNode focusOnSearch = FocusNode();
  bool isSearchClicked = false;

  List questions = [{}];

  void _searchClick() {
    setState(() {
      isSearchClicked = !isSearchClicked;
    });
  }

  void submit() {
    _formKey.currentState.save();
  }

  Future<http.Response> getQuestions() {
    String url =
        'https://api.stackexchange.com/2.2/search/advanced?key=U4DMV*8nvpm3EOpvf69Rxw((&site=stackoverflow&order=desc&sort=activity&user=anuradha&filter=default';
    return http.get(url);
  }

  _buildSearchInputField() {
    return isSearchClicked
        ? TextFormField(
            controller: textController,
            focusNode: focusOnSearch,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a question to search.';
              }
            },
            decoration: InputDecoration(
                hintText: 'your question here',
                labelText: 'question',
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {},
                )))
        : Container();
  }

  _buildQuestionButton() {
    return Row(
      children: <Widget>[
        RaisedButton(
          child: Text('Ask Questions'),
          onPressed: () {
            _searchClick();
          },
          color: Colors.blue[100],
        )
      ],
    );
  }

  _buildCounts(data) {
    var tagCount = data["score"];
    var answerCount = data["answer_count"];
    var viewCount = data["view_count"];
    return Row(
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
    );
  }

  Widget _buildQuestionCard(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Card(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildCounts(questions[index]),
                Container(
                  padding: EdgeInsets.all(5.0),
                  width: 330.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => DetailsView(
                                  questions[index]['questionDetails'])));
                    },
                    child: Text(
                      questions[index]['title'],
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 14.0),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(5.0),
                    child: RaisedButton(
                      child: Text(
                        questions[index]['tags'][0],
                      ),
                      onPressed: () {},
                    ))
              ],
            ),
          )
        ],
      )),
    );
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

  _buildQuestionsHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
      ),
      child: Text(
        'Latest Questions',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
    );
  }

  _buildBody(BuildContext context, List questionsData) {
    questions = questionsData;

    return Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            _buildQuestionButton(),
            _buildSearchInputField(),
            _buildQuestionsHeader(),
            Expanded(
              child: ListView.builder(
                itemBuilder: _buildQuestionCard,
                itemCount: questions.length,
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
