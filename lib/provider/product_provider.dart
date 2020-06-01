import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopvenue_app/expection/http_expection.dart';
import 'package:shopvenue_app/models/product.dart';

class Products with ChangeNotifier {
  final String authToken, userId;

  List<Product> _productData = [
    // Product(
    //   id: "P001",
    //   name: "Watch",
    //   price: 2500,
    //   desc: "A quality watch is at least made of Stainless Steel.",
    //   imageUrl:
    //       "https://images-na.ssl-images-amazon.com/images/I/61v-k7WMxqL._UX679_.jpg",
    //   isFav: false,
    // ),
    // Product(
    //   id: "P002",
    //   name: "Shirt",
    //   price: 1000,
    //   desc: "Premium Cotton T-Shirt",
    //   imageUrl:
    //       "https://images-na.ssl-images-amazon.com/images/I/61-TuCrKZ7L._UY550_.jpg",
    //   isFav: false,
    // ),
    // Product(
    //   id: "P003",
    //   name: "Laptop",
    //   price: 400000,
    //   desc: "An excellent choice for power users.",
    //   imageUrl:
    //       "https://i.pcmag.com/imagery/reviews/0227QDT3xYwn3xEOpyiJpNU-1.fit_scale.size_1028x578.v_1574212824.jpg",
    //   isFav: false,
    // ),
    // Product(
    //   id: "P004",
    //   name: "Shoes",
    //   price: 2500,
    //   desc: "B23 High-Top Sneakers in Dior Oblique",
    //   imageUrl: "https://i.ebayimg.com/images/g/vpcAAOSwbRxc5aVt/s-l800.webp",
    //   isFav: false,
    // ),
    // Product(
    //   id: "P005",
    //   name: "Galaxy S10",
    //   price: 2500,
    //   desc:
    //       "The phone comes with a 6.10-inch touchscreen display and an aspect ratio of 19:9. Samsung Galaxy S10 is powered by a 1.9GHz octa-core Samsung Exynos 9820 processor. It comes with 8GB of RAM. The Samsung Galaxy S10 runs Android 9.0 and is powered by a 3400mAh non-removable battery.",
    //   imageUrl:
    //       "https://www.technobezz.com/files/uploads/2018/07/Samsung-Galaxy-S10.jpg",
    //   isFav: false,
    // ),
    // Product(
    //   id: "P006",
    //   name: "Shoes",
    //   price: 2500,
    //   desc: "B23 High-Top Sneaker in Gradient Blue Dior Oblique",
    //   imageUrl:
    //       "https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/cover_image_2/870x580/17f82f742ffe127f42dca9de82fb58b1/W/7/1581010860_3SH118YUN_H560_E02_ZHC.jpg",
    //   isFav: false,
    // ),
  ];

  Products(this.authToken, this.userId, this._productData);

  List<Product> get productData {
    return [..._productData]; //Needs to update SDK Version to 2.2.2
  }

  List<Product> get favorites {
    return _productData.where((product) => product.isFav).toList();
  }

  Product findById(String id) {
    return _productData.firstWhere((product) => product.id == id);
  }

  //This method add new products in the list
  Future<void> addProduct(Product product) async {
    final url =
        'https://shop-venue.firebaseio.com/products.json?auth=$authToken';
    // const url_1 = 'http://ip.jsontext.com/';

    // http.Response response = await http.get(url_1);

    // print(response.statusCode);
    try {
      final response = await http.post(url,
          body: json.encode({
            'name': product.name,
            'price': product.price,
            'desc': product.desc,
            'imageUrl': product.imageUrl,
            'isFav': product.isFav,
            'creatorId': userId,
          })); //future gives a response after posting to the database

      print(json.decode(response.body)['name']);
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          name: product.name,
          price: product.price,
          desc: product.desc,
          imageUrl: product.imageUrl);
      _productData.add(newProduct);
      notifyListeners();
    }
    //If we get an error during added product it will catch the error
    catch (error) {
      print(error);
      throw (error);
    }
  }

  //This function fetches the products from firebase
  Future<void> fetchProductData([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : "";

    final url =
        'https://shop-venue.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final favResponse = await http.get(
          'https://shop-venue.firebaseio.com/userFav/$userId.json?auth=$authToken');
      final favData = json.decode(favResponse.body);
      final List<Product> productGot = [];
      // print(extractedData.toString());
      extractedData.forEach((prodId, prodData) {
        productGot.add(
          Product(
            id: prodId,
            name: prodData['name'],
            desc: prodData['desc'],
            price: double.parse(prodData['price'].toString()),
            imageUrl: prodData['imageUrl'],
            isFav: favData == null ? false : favData[prodId] ?? false,
          ),
        );
      });
      _productData = productGot;
      notifyListeners();
      // print(productData);
    } catch (error) {
      print(error.message);
      throw (error);
    }
  }

  //This function updates the current product
  Future<void> updateProduct(String id, Product upProduct) async {
    final productIndex = _productData.indexWhere((prod) => prod.id == id);
    try {
      if (productIndex >= 0) {
        final url =
            'https://shop-venue.firebaseio.com/products/$id.json?auth=$authToken';
        await http.patch(url,
            body: json.encode({
              'name': upProduct.name,
              'price': upProduct.price,
              'desc': upProduct.desc,
              'imageUrl': upProduct.imageUrl,
            }));
        _productData[productIndex] = upProduct;
        notifyListeners();
      }
    } catch (error) {
      print(error.message);
      throw (error);
    }
  }

  //This Function deleted the particular Product
  Future<void> deleteProduct(String id) async {
    final url =
        'https://shop-venue.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex =
        _productData.indexWhere((prod) => prod.id == id);
    var existingProduct = _productData[existingProductIndex];
    _productData.removeAt(existingProductIndex);
    notifyListeners();

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        _productData.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpExpection("Couldn't delete product!");
      } else {
        existingProduct = null;
      }
    } catch (error) {
      _productData.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpExpection("Couldn't delete product!");
    }
  }
}
