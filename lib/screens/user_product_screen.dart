import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';
import 'package:shopvenue_app/widgets/drawer.dart';
import 'package:shopvenue_app/widgets/user_product_item.dart';

import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = '/user_product_screen';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).productData;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.plusSquare),
            onPressed: () =>
                Navigator.pushNamed(context, EditProductScreen.routeName),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (ctx, index) => UserProductItem(
            id: products[index].id,
            title: products[index].name,
            imageUrl: products[index].imageUrl,
          ),
          itemCount: products.length,
        ),
      ),
    );
  }
}
