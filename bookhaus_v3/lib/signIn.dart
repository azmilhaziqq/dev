import 'package:bookhaus_v3/auth_provider.dart';
import 'package:flutter/material.dart';

import './auth.dart';
class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final formKey = new GlobalKey<FormState>();
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  String _email, _password;
  FormType _formType = FormType.login;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        var auth = AuthProvider.of(context).auth;
        if(_formType == FormType.login){
          String userId = await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        }else{
          String userId = await auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.teal,
          title: new Text('BookHaus Login'),
        ),
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage("assets/book.jpg"),
              fit: BoxFit.cover,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // new FlutterLogo(
                //   size: _iconAnimation.value * 100,
                // ),
                new Form(
                  key: formKey,
                  child: new Theme(
                    data: new ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                                color: Colors.teal, fontSize: 20.0))),
                    child: new Container(
                      padding: const EdgeInsets.all(40.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: buildInputs() + buildSubmitButton(),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: "Enter Email"),
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "Enter Password"),
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
      new Padding(
        padding: const EdgeInsets.only(top: 10.0),
      ),
    ];
  }

  List<Widget> buildSubmitButton() {
    if(_formType == FormType.login){
      return [
      new MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        child: new Text("Login"),
        onPressed: validateAndSubmit,
        splashColor: Colors.redAccent,
      ),
      new FlatButton(
        child:
            new Text('Create an account', style: new TextStyle(fontSize: 20.0)),
        onPressed: moveToRegister,
      )
      ];
    }else {
      return [
      new MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        child: new Text("Create an account"),
        onPressed: validateAndSubmit,
        splashColor: Colors.redAccent,
      ),
      new FlatButton(
        child:
            new Text('Have an account? Login', style: new TextStyle(fontSize: 20.0)),
        onPressed: moveToLogin,
      )
      ];
    }
  }
}
