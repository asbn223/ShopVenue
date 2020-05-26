import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/cart_provider.dart' show Cart;
import 'package:shopvenue_app/provider/order_provider.dart';
import 'package:shopvenue_app/screens/order_screen.dart';
import 'package:shopvenue_app/widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart_screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
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
                  OrderButton(cart),
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

class OrderButton extends StatefulWidget {
  final Cart cart;
  OrderButton(this.cart);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context, listen: false);

    return FlatButton(
        child: _isLoading
            ? CircularProgressIndicator()
            : Text(
                'Checkout',
                style: TextStyle(fontSize: 16.0, fontFamily: "Oxanium"),
              ),
        onPressed: widget.cart.itemInCart == 0
            ? null
            : () async {
                setState(() {
                  _isLoading = false;
                });
                if (widget.cart.itemInCart != 0) {
                  await order.addOrder(widget.cart.cartItems.values.toList(),
                      widget.cart.totalAmt);
                  widget.cart.clearFromCart();
                  Navigator.pushNamed(context, OrderScreen.routeName);
                } else {
                  await showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text("Error Occured"),
                          content: Text("Your Cart is Empty"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                }
                setState(() {
                  _isLoading = true;
                });
              });
  }
}
