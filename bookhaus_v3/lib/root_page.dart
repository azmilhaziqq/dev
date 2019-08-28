import 'package:bookhaus_v3/auth_provider.dart';
import 'package:flutter/material.dart';

import './signIn.dart';
import './home.dart';
class RootPage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus{
  signedIn,
  notSignedIn
}

class _RootPageState extends State<RootPage>{

  AuthStatus authStatus= AuthStatus.notSignedIn;
  
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((userId){
      setState(() {
       authStatus = userId == null? AuthStatus.notSignedIn : AuthStatus.signedIn; 
      });
    });
  }

  void _signedIn(){
      setState(() {
        authStatus = AuthStatus.signedIn;
      });
  }

  void _signedOut(){
     setState(() {
        authStatus = AuthStatus.notSignedIn;
      });
  }
  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
          onSignedIn:_signedIn,
        );
      case AuthStatus.signedIn:
        return new Home(
          onSignedOut: _signedOut,
        );
      }
    }
  } 