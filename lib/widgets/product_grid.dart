import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';
import 'package:shopvenue_app/widgets/product_items.dart';

class ProductGrid extends StatelessWidget {
  final bool showFav;

  ProductGrid({this.showFav});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final product = showFav ? productData.favorites : productData.productData;
    return GridView.builder(
      padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      itemCount: product.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: product[index],
        child: ProductItem(),
      ),
    );
  }
}
