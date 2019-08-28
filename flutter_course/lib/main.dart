//Import libraries
import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';

//Main function where flutter will look for and call first to start the app
void main() => runApp(MyApp());

//Create class for widget and inherit material.dart package
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*materialApp to wrap entire App (core widget)
    Scaffold() create a new page in App */
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('EasyList'),
          ),
          body: ProductManager('Food Tester'),
          ),
    );
  }
}
