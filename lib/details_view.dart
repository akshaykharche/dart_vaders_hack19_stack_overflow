import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  final questionDetails;

  DetailsView(this.questionDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
            title: Text(
              'Stack Overflow',
            ),
      ),
      body: Column(
        children: <Widget>[
          Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue.shade100,
                foregroundDecoration: new BoxDecoration(
                  border: Border.all(
                    color: Colors.amber.shade400,
                  ),
                ),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Image.asset("assets/dummy-user.png", width: 50),
                      margin: const EdgeInsets.only(right: 10),
                    ),
                    Expanded(
                      child: Text(
                        'Question added by Name Question added by Name Question added by Name ',
                        style: new TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Asked",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      alignment: Alignment(10.0, 0.0),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue.shade50,
                foregroundDecoration: new BoxDecoration(
                  border: Border.all(
                    color: Colors.amber.shade400,
                  ),
                ),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right:8.0),
                      child: Text(
                          '10',
                          style: new TextStyle(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                          ),
                        ),
                    ),
                    Expanded(
                      child: Text(
                        'Answers',
                        style: new TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
        ],
      )
    ) ;
  }
}