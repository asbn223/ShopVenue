import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopvenue_app/expection/http_expection.dart';

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

  Future<void> toggleFav({String authToken, String userId}) async {
    final backUPfav = isFav;
    isFav = !isFav;
    notifyListeners();
    final url =
        'https://shop-venue.firebaseio.com/userFav/$userId/$id.json?auth=$authToken';

    try {
      final res = await http.put(url, body: json.encode(isFav));
      if (res.statusCode >= 400) {
        isFav = backUPfav;
        notifyListeners();
      }
    } catch (error) {
      isFav = backUPfav;
      notifyListeners();
      throw HttpExpection("Couldn't mark as favorites!");
    }
  }
}
