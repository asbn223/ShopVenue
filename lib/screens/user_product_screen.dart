import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';
import 'package:shopvenue_app/widgets/drawer.dart';
import 'package:shopvenue_app/widgets/user_product_item.dart';

import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = '/user_product_screen';

  Future<void> _refreshedProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProductData(true);
  }

  @override
  Widget build(BuildContext context) {
//    final products = Provider.of<Products>(context);
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
      body: FutureBuilder(
        future: _refreshedProducts(context),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return RefreshIndicator(
              onRefresh: () => _refreshedProducts(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<Products>(
                  builder: (BuildContext context, Products products, _) {
                    return ListView.builder(
                      itemBuilder: (ctx, index) => UserProductItem(
                        id: products.productData[index].id,
                        title: products.productData[index].name,
                        imageUrl: products.productData[index].imageUrl,
                      ),
                      itemCount: products.productData.length,
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
