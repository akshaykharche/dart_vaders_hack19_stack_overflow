import 'package:flutter/material.dart';

import './landing_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          Notes.routeName: (BuildContext context) => new Notes()
        },
        home: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/imageedit_1_4358849406.png',
                        fit: BoxFit.contain,
                        height: 20,
                        width: 50,
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
                drawer: new Drawer(
                  child: new Column(
                    children: <Widget>[
                      new UserAccountsDrawerHeader( 
                        decoration: new BoxDecoration(color: Colors.orange),                       
                        accountName: new Text(
                          "User name",
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                        accountEmail: new Text(
                          "username@email.com",
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                        otherAccountsPictures: <Widget>[
                          new GestureDetector(
                            onTap: () => _onTapOtherAccounts(context),
                            child: new Semantics(
                              label: 'Switch Account',
                              child: new CircleAvatar(
                                backgroundColor: Colors.brown,
                                child: new Text('RB'),
                              ),
                            ),
                          )
                        ],
                      ),
                      new Column(
                        children: <Widget>[
                          new ListTile(
                            leading: new Icon(Icons.table_chart),
                            title: new Text('Tags'),
                            onTap: () => _onListTileTap(context),
                          ),
                          new Divider(),
                          new ListTile(
                            leading: new Icon(Icons.tag_faces),
                            title: new Text('User Search'),
                            onTap: () => _onListTileTap(context),
                          ),
                          new Divider(),
                          new ListTile(
                            leading: new Icon(Icons.settings),
                            title: new Text('Settings'),
                            onTap: () => _onListTileTap(context),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                body: LandingPage())));
  }
}

_onListTileTap(BuildContext context) {
  Navigator.of(context).pop();
  showDialog<Null>(
    context: context,
    child: new AlertDialog(
      title: Text('Coming soon'),
      actions: <Widget>[
        new FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

_onTapOtherAccounts(BuildContext context) {
  Navigator.of(context).pop();
  showDialog<Null>(
    context: context,
    child: new AlertDialog(
      title: const Text('Coming soon'),
      actions: <Widget>[
        new FlatButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

class Notes extends StatelessWidget {
  static final String routeName = '/notes';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(),
      appBar: new AppBar(
        title: new Text('Notes'),
      ),
      body: new Center(
        child: new Text('Notes', style: new TextStyle(fontSize: 24.0)),
      ),
    );
  }
}
