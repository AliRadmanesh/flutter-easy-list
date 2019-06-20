import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../models/product.dart';
import '../../scoped-model/main.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    /*
      BEST PRACTICE: When you want to return nothing to the screen
      you can't just return null or undefined! you must return a
      widget. The good part of returning a [Container] is that
      it won't occupy any space on the screen and also won't impact
      performance issue.
    */
    Widget productCards;
    if (products.length > 0) {
      /*
        [ListView] is great for limited amount of widgets/elements
        inside it. But for the situation where you have dynamic
        amount of items or very long list of items, [ListView]
        is inefficient. because all elements will be rendered
        on the screen, even those which aren't visible on the screen
        so it's not a good idea for long lists. instead we use
        [ListView.builder()] for this ocassion.
      */
      productCards = ListView.builder(
        /*
          [itemBuilder] contains a method which defines what does
          building an item mean & how is an item built.
        */
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        /* [itemCount] indicates how many items will have to be built */
        itemCount: products.length,
      );
    } else {
      productCards = Container();
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildProductList(model.displayedProducts);
      },
    );
  }
}
