import 'package:flutter/material.dart';

import '../widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductsPage(this.products);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            /* [automaticallyImplyLeading] means it automatically tries to infer
                  what the first icon or action in the app bar should be
              */
            title: Text('Choose'),
          ),
          /* [ListTile] is a neat widget which looks nice, out of the box and
                positions its child elements nicely :)
            */
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              /* Named route */
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* [drawer] is on the left. [endDrawer] is on the right. */
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Easy List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: Products(products),
    );
  }
}
