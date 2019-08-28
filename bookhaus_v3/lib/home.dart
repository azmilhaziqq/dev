import 'package:bookhaus_v3/auth_provider.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  Home({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userId;
  String email;
  
  //Class to Sign out
  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var auth = AuthProvider.of(context).auth;
    //email = auth.getEmail() as String;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.tealAccent[700],
          title: Text('BookHaus'),
          actions: <Widget>[
            new IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {}),
            new IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {}),
            
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(accountName: Text('Haha'),accountEmail: Text('hehe')),
              new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 15.0, color: Colors.black)),
                onPressed: ()=> _signOut(context))
            ],
          ),
        ),
        body: new Container(
            child: new Center(
                child: new Text('Welcome',
                    style: new TextStyle(fontSize: 32.0)))));
  }
}
