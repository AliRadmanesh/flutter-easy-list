import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  /* [WillPopScope] will listen for back button being pressed on Android devices.
    [onWillPop] holds a function which is executed when the user wants to leave
    the page.
    NOTE: This widget will block back button (both hardware & software). So it's
    your responsibility to handle back behaviour by popping the current screen.
  */
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          /* mainAxisAlignment is for top to bottom alignment */
          // mainAxisAlignment: MainAxisAlignment.center,
          /* crossAxisAlignment is for right to left alignment */
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(title),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('DELETE'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
