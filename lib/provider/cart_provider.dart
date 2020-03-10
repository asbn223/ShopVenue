import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.name,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItem = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItem};
  }

  int get itemInCart {
    return _cartItem == null ? 0 : _cartItem.length;
  }

  //Adding items into the Cart
  void addItemInCart(String productId, double price, String name) {
    if (_cartItem.containsKey(productId)) {
      _cartItem.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _cartItem.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          name: name,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  //total amout of the product in the cart
  double get totalAmt {
    var total = 0.0;
    _cartItem.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  //Remove Particular Items from cart
  void removeItemFromCart(String productId) {
    _cartItem.remove(productId);
    notifyListeners();
  }
}
