import 'package:flutter/material.dart';

class Votes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
