/*  Pre-defined functions and tools for creating our application. */
import 'package:flutter/material.dart';
/* rendering class is usefull for debugging the user interface */
// import 'package:flutter/rendering.dart';
import './pages/home.dart';

/* This is our app's core function, where it starts to launch! */
void main() {
  /* To show each element, its padding & margin, use this: */
  // debugPaintSizeEnabled = true;
  /* To show where text baseline is, you can enable this: */
  // debugPaintBaselinesEnabled = true;
  /* To show tapping on each element you can use this var: */
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /*
    This widget is the root of your application.
    Everything in flutter is widget. even
    our whole application is a widget!
    We have 2 kind of widgets:
    1. Stateless: Displaying something
    2. Stateful: Can work with date and modify them.
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*
        [debugShowMaterialGrid] shows grid in the whole
        page to recognize how much space your element take.
      */
      // debugShowMaterialGrid: true,
      title: 'Easy List',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}
