import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopvenue_app/provider/cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    const url = 'https://shop-venue.firebaseio.com/orders.json';
    try {
      final timeStamp = DateTime.now();
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'products': cartProduct
                .map((cartItem) => {
                      'id': cartItem.id,
                      'name': cartItem.name,
                      'quantity': cartItem.quantity,
                      'price': cartItem.price,
                    })
                .toList(),
            'dateTime': timeStamp.toIso8601String(),
          })); //future gives a response after posting to the database

      print(json.decode(response.body)['name']);
      final newProduct = _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProduct,
          dateTime: timeStamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchOrderData() async {
    const url = 'https://shop-venue.firebaseio.com/orders.json';
    try {
      final response = await http.get(url);
      final extractedOrderData =
          json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> gotOrder = [];
      if (extractedOrderData == null) {
        return;
      }
      // print(extractedData.toString());
      extractedOrderData.forEach((orderID, orderValue) {
        List<dynamic> cartItem = orderValue['products'];
        gotOrder.add(
          OrderItem(
            id: orderID,
            amount: double.parse(orderValue['amount'].toString()),
            products: cartItem
                .map((item) => CartItem(
                      id: item['id'],
                      name: item['name'],
                      price: double.parse(item['price'].toString()),
                      quantity: item['quantity'],
                    ))
                .toList(),
            dateTime: DateTime.parse(orderValue['dateTime'].toString()),
          ),
        );
      });
      _orders = gotOrder;
      notifyListeners();
      // print(productData);
    } catch (error) {
      print(error.toString());
      throw (error);
    }
  }
}
