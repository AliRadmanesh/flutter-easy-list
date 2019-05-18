import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  final Map<String, String> startingProduct;

  /* Here in class constructor we use default value */
  ProductManager({ this.startingProduct }) {
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
  List<Map<String, String>> _products = []; // It's like an array of Objects!

  @override
  void initState() {
    // print('[ProductManager State] initState()');
    /*
      No need to call setState here, because this method runs before
      build method even exist! so no need to change and re-render build.
    */
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    /* Call parent initState() method and must be at the end of this block. */
    super.initState();
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    // print('[ProductManager State] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  /*
    Map is like Object in JS. It holds key-value variables.
    Keys must be string or numbers and values can be of any type.
    If you have multiple value types, for generic title (down below)
    you should use dynamic.
  */
  void _addProduct(Map<String, String> product) {
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
    // print('[ProductManager State] build()');
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(_addProduct),
        ),
        Expanded(
          child: Products(_products, deleteProduct: _deleteProduct),
        )
      ],
    );
  }
}
