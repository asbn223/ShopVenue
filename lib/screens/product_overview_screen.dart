import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/cart_provider.dart';
import 'package:shopvenue_app/widgets/badge.dart';
import 'package:shopvenue_app/widgets/product_grid.dart';

import 'cart_screen.dart';

enum FilterOptions { Favorites, All }

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool showFav = false;

  @override
  Widget build(BuildContext context) {
//    final productData = Provider.of<Products>(context).productData;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shop Venue"),
//          centerTitle: true,
          actions: <Widget>[
            Consumer<Cart>(
              builder: (context, cart, child) {
                return Badge(
                  child: child,
                  value: cart.itemInCart.toString(),
                );
              },
              child: IconButton(
                icon: Icon(FontAwesomeIcons.shoppingBasket),
                onPressed: () =>
                    Navigator.pushNamed(context, CartScreen.routeName),
              ),
            ),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (FilterOptions selectedOption) {
                setState(() {
                  if (selectedOption == FilterOptions.Favorites) {
                    showFav = true;
                  } else {
                    showFav = false;
                  }
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Show Favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ],
            ),
          ],
        ),
        body: ProductGrid(
          showFav: showFav,
        ),
      ),
    );
  }
}
