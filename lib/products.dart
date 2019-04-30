import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products(this.products) {
    // print('[Product Widget] Constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/food.jpg'),
          Text(products[index]),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    /*
    ## BEST PRACTICE: When you want to return nothing to the screen
    ## you can't just return null or undefined! you must return a
    ## widget. The good part of returning a [Container] is that
    ## it won't occupy any space on the screen and also won't impact
    ## performance issue.
    */
    Widget productCards = Container();
    if (products.length > 0) {
      /*
      ## [ListView] is great for limited amount of widgets/elements
      ## inside it. But for the situation where you have dynamic
      ## amount of items or very long list of items, [ListView]
      ## is inefficient. because all elements will be rendered
      ## on the screen, even those which aren't visible on the screen
      ## so it's not a good idea for long lists. instead we use
      ## [ListView.builder()] for this ocassion.
      */
      productCards = ListView.builder(
        /*
        ## [itemBuilder] contains a method which defines what does
        ## building an item mean & how is an item built.
        */
        itemBuilder: _buildProductItem,
        /*
        ## [itemCount] indicates how many items will have to be built
        */
        itemCount: products.length,
      );
    } else {
      productCards = Center(
        child: Text('No products found, please add some.'),
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    // print('[Product Widget] build()');
    return _buildProductList();
  }
}
