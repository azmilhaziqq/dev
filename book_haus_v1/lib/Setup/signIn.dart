import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password ; 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Form(
          //Implement Key
          key: _formKey,
          child: Column(
            children: <Widget>[
              //Implement Fields
              TextFormField(
                validator: (input){
                  if(input.isEmpty){
                    return 'Please Type in Email';
                  }
                },
                onSaved:(input) => _email = input ,
                decoration: InputDecoration( 
                  labelText:'Email'
                ),z
              ),
              TextFormField(
                validator:(input){
                  if(input.length<6){
                    return 'Password need 6 characters';
                  }
                },
                onSaved:(input) => _password = input ,
                decoration: InputDecoration( 
                  labelText:'Password'
                ),
                obscureText: true,
              ),
              RaisedButton( 
                onPressed: signIn,
                child: Text('Sign In'),
              )
            ],
            ),
          ),
        );
  }

  Future<void> signIn() async{
    //Validate Fields
    final formState=  _formKey.currentState;
    if(formState.validate()){
    //Login to FireBase
      formState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        Navigator.push(context, MaterialPageRoute(builder:(context) => Home()));
        //Navigate To Home
      }catch(e){
        print(e.message); 
      }
      
    }
  }
}
