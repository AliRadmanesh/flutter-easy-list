/*  Pre-defined functions and tools for creating our application. */
import 'package:flutter/material.dart';
/* rendering class is usefull for debugging the user interface */
// import 'package:flutter/rendering.dart';
import './pages/auth.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/product.dart';

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

class MyApp extends StatefulWidget {
  /*
    This widget is the root of your application.
    Everything in flutter is widget. even
    our whole application is a widget!
    We have 2 kind of widgets:
    1. Stateless: Displaying something
    2. Stateful: Can work with date and modify them.
  */

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  /*
    Also our products list is final, we can add to it.
    final means it couldn't be changed. but we can add
    to it (modify the exsiting value)! we just can't
    assign a new value to it, like _products = ['Ali'];
    reason: Objects and lists in general are reference types
    and we store a reference to their contents.
    Note: In final variables, we can modify them, but
    we can't assign a new value to them.
    e.g. final age = 25; age.round() is OK!
  */
  List<Map<String, dynamic>> _products = []; // It's like an array of Objects!

  /*
    Map is like Object in JS. It holds key-value variables.
    Keys must be string or numbers and values can be of any type.
    If you have multiple value types, for generic title (down below)
    you should use dynamic.
  */
  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
      // print(_products);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

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
        // fontFamily: 'Oswald', // If you want a global font family for the app
        buttonColor: Colors.deepPurple, // Default color of all buttons!
      ),
      // home: AuthPage(),
      /* Global route registry */
      routes: {
        '/': (BuildContext context) => AuthPage(),
        // '/login': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => ProductsPage(_products),
        '/admin': (BuildContext context) =>
            ProductsAdminPage(_addProduct, _deleteProduct),
      },
      /*
        [onGenerateRoute] is executed when we navigate to a named route
        only if that route is NOT registered in our route registry.
        It takes a function and we have to return a route where we wanna go to.
      */
      onGenerateRoute: (RouteSettings settings) {
        /*
          The [settings] hold the name we wanna navigate to. So we can encode
          our own information into the name.
        */
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
          // When we split the /, the first elemnt is always an empty string ''.
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'],
                _products[index]['image'],
                _products[index]['price'],
                _products[index]['description']),
          );
        }
        return null;
      },
      /*
        [onUnknownRoute] will execute whenever [onGenerateRoute] fails to
        generate routes. This allows us to show some dummy fallback page.
      */
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => ProductsPage(_products),
        );
      },
    );
  }
}
