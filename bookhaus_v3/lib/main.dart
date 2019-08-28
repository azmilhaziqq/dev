import 'package:bookhaus_v3/auth_provider.dart';
import 'package:flutter/material.dart';

import './auth.dart';
import './root_page.dart';
import './auth_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return AuthProvider(
      auth: Auth(),
      child: new MaterialApp(
        title: 'BookHaus',
        home:  new RootPage(),
        theme: new ThemeData(
          primarySwatch: Colors.blue
        )
      ),
    );
  }
}



