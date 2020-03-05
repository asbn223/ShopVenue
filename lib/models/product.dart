import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final double price;
  final String desc;
  final String imageUrl;
  bool isFav;

  Product({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.desc,
    this.isFav = false,
    @required this.imageUrl,
  });

  void toggleFav() {
    isFav = !isFav;
    notifyListeners();
  }
}
