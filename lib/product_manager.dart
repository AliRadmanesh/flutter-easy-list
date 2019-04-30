import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;

  /*
  ## Here in class constructor we use default value
  */
  ProductManager({this.startingProduct}) {
    // print('[ProductManager Widget] Constructor');
  }

  @override
  State<StatefulWidget> createState() {
    // print('[ProductManager Widget] createState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  /*
  ## Also our products list is final, we can add to it.
  ## final means it couldn't be changed. but we can add
  ## to it (modify the exsiting value)! we just can't
  ## assign a new value to it, like _products = ['Ali'];
  ## reason: Objects and lists in general are reference types
  ## and we store a reference to their contents.
  ## Note: In final variables, we can modify them, but
  ## we can't assign a new value to them.
  ## e.g. final age = 25; age.round() is OK!
  */
  List<String> _products = [];

  @override
  void initState() {
    // print('[ProductManager State] initState()');
    /*
    ## No need to call setState here, because this method runs before
    ## build method even exist! so no need to change and re-render build.
    */
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    /*
    ## Call parent initState() method and must be at the end of this block.
    */
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    // print('[ProductManager State] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
      // print(_products);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('[ProductManager State] build()');
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(_addProduct),
        ),
        Expanded(
          child: Products(_products),
        )
      ],
    );
  }
}
