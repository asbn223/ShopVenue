import 'package:flutter/material.dart';
import 'package:shopvenue_app/widgets/product_grid.dart';

class ProductOverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final productData = Provider.of<Products>(context).productData;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shop Venue"),
          centerTitle: true,
        ),
        body: ProductGrid(),
      ),
    );
  }
}
