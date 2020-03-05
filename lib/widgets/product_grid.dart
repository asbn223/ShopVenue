import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';
import 'package:shopvenue_app/widgets/product_items.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context).productData;

    return GridView.builder(
      padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      itemCount: productData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (context, index) => ProductItem(
        name: productData[index].name,
        id: productData[index].id,
        imageUrl: productData[index].imageUrl,
      ),
    );
  }
}
