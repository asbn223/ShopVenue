import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/cart_provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';

class CartItem extends StatelessWidget {
  final String name;
  final String id;
  final double price;
  final int quanity;
  final String productId;

  CartItem({
    this.id,
    this.name,
    this.price,
    this.productId,
    this.quanity,
  });

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context).productData;
    final cartData = productData.firstWhere((product) {
      return product.id == productId;
    });

    final cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.only(right: 10.0),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Colors.red,
        child: Icon(
          FontAwesomeIcons.trashAlt,
          color: Colors.white,
          size: 30.0,
        ),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        cart.removeItemFromCart(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to remove $name from your cart?"),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(
                  child: Image.network(
                    cartData.imageUrl,
//                  fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text(name),
            subtitle: Text('Total \$ ${price * quanity}'),
            trailing: Text('$quanity x'),
          ),
        ),
      ),
    );
  }
}
