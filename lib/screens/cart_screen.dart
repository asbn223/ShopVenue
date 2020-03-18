import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/cart_provider.dart' show Cart;
import 'package:shopvenue_app/provider/order_provider.dart';
import 'package:shopvenue_app/widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart_screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text("\$ ${cart.totalAmt.toStringAsFixed(1)}"),
//                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  FlatButton(
                      child: Text(
                        'Checkout',
                        style: TextStyle(fontSize: 16.0, fontFamily: "Oxanium"),
                      ),
                      onPressed: () {
                        order.addOrder(
                            cart.cartItems.values.toList(), cart.totalAmt);
                        cart.clearFromCart();
//                        Navigator.pushNamed(context, OrderScreen.routeName);
                      })
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, index) => CartItem(
              id: cart.cartItems.values.toList()[index].id,
              name: cart.cartItems.values.toList()[index].name,
              price: cart.cartItems.values.toList()[index].price,
              quanity: cart.cartItems.values.toList()[index].quantity,
              productId: cart.cartItems.keys.toList()[index],
            ),
            itemCount: cart.itemInCart,
          )),
        ],
      ),
    );
  }
}
