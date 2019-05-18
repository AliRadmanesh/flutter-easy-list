import 'package:flutter/material.dart';

import '../product_manager.dart';
import './products_admin.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* [drawer] is on the left. [endDrawer] is on the right. */
      drawer: Drawer(
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
              title: Text('Manage Products'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProductsAdminPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Easy List'),
      ),
      body: ProductManager(),
    );
  }
}
