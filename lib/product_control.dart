import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;

  /*
  ## bind _addProduct() of parent widget to this.addProduct
  ## that is a function reference.
  */
  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        /*
        ## Call addProduct function of parent widget to change the state
        */
        addProduct('Sweets');
      },
      child: Text('Add Product'),
    );
  }
}
