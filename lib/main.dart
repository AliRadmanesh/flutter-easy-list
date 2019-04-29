// Pre-defined functions and tools for creating our application.
import 'package:flutter/material.dart';

import './product_manager.dart';

// This is our app's core function, where it starts to launch!
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy List',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Easy List'),
        ),
        body: ProductManager('Food Tester'),
      ),
    );
  }
}
