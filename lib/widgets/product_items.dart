import 'package:flutter/material.dart';
import 'package:shopvenue_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl, name, id;

  ProductItem({
    this.id,
    this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    void _selectedProduct(BuildContext context) {
      Navigator.pushNamed(context, ProductDetailScreen.routeName,
          arguments: id);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black38,
            leading: IconButton(
              iconSize: 30,
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            ),
            trailing: IconButton(
              iconSize: 30,
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),
          header: GridTileBar(
            backgroundColor: Colors.black38,
            title: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          child: GestureDetector(
            onTap: () => _selectedProduct(context),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
