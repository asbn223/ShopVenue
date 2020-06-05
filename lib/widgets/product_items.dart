import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/models/product.dart';
import 'package:shopvenue_app/provider/auth_provider.dart';
import 'package:shopvenue_app/provider/cart_provider.dart';
import 'package:shopvenue_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    final selectedProduct = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    void _selectedProduct(BuildContext context) {
      Navigator.pushNamed(context, ProductDetailScreen.routeName,
          arguments: selectedProduct.id);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black38,
            leading: Consumer<Product>(
              builder: (ctx, builder, _) {
                return IconButton(
                  iconSize: 30,
                  icon: selectedProduct.isFav
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    selectedProduct.toggleFav(
                        authToken: auth.token, userId: auth.userId);
                  },
                );
              },
            ),
            trailing: IconButton(
              iconSize: 30,
              icon: Icon(FontAwesomeIcons.shoppingBasket),
              onPressed: () {
                cart.addItemInCart(selectedProduct.id, selectedProduct.price,
                    selectedProduct.name);
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Item has been added in the cart"),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "UNDO",
                      textColor: Colors.white,
                      onPressed: () =>
                          cart.removeSingleItem(selectedProduct.id),
                    ),
                  ),
                );
              },
            ),
          ),
          header: GridTileBar(
            backgroundColor: Colors.black38,
            title: Text(
              selectedProduct.name,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          child: GestureDetector(
            onTap: () => _selectedProduct(context),
            child: Hero(
              tag: 'product${selectedProduct.id}',
              child: FadeInImage(
                  placeholder: AssetImage('assets/placeholder.png'),
                  image: NetworkImage(
                    selectedProduct.imageUrl,
                  ),
                  fit: BoxFit.cover),
            ),
          )),
    );
  }
}
