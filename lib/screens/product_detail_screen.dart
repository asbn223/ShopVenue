import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product_detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedProductData = Provider.of<Products>(context, listen:false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProductData.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'product$id',
              child: Container(
                height: 300.0,
                width: double.infinity,
                child: Image.network(
                  selectedProductData.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "\$ " + selectedProductData.price.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                selectedProductData.desc,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
