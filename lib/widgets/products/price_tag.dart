import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 2.5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        '\$$price',
        // Above string is a mix of harcode string + dynamic value
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
