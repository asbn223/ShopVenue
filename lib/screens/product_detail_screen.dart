import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product_detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final productData = Provider.of<Products>(context).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(productData.name),
      ),
    );
  }
}
