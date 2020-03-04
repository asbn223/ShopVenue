import 'package:flutter/material.dart';
import 'package:shopvenue_app/models/product.dart';
import 'package:shopvenue_app/widgets/product_items.dart';

class ProductOverViewScreen extends StatelessWidget {
  List<Product> productData = [
    Product(
      id: "P001",
      name: "Watch",
      price: 2500,
      desc: "A quality watch is at least made of Stainless Steel.",
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/I/61v-k7WMxqL._UX679_.jpg",
      isFav: false,
    ),
    Product(
      id: "P002",
      name: "Shirt",
      price: 1000,
      desc: "Premium Cotton T-Shirt",
      imageUrl:
          "https://scontent.fktm8-1.fna.fbcdn.net/v/t1.0-9/46245129_2178591129050867_1617584155116175360_n.png?_nc_cat=110&_nc_sid=8024bb&_nc_ohc=tmlSik3prqIAX9OE3K4&_nc_ht=scontent.fktm8-1.fna&oh=ca17fce650324a77631e8834af90b479&oe=5E82A84C",
      isFav: false,
    ),
    Product(
      id: "P003",
      name: "Laptop",
      price: 400000,
      desc: "An excellent choice for power users.",
      imageUrl:
          "https://i.pcmag.com/imagery/reviews/0227QDT3xYwn3xEOpyiJpNU-1.fit_scale.size_1028x578.v_1574212824.jpg",
      isFav: false,
    ),
    Product(
      id: "P004",
      name: "Shoes",
      price: 2500,
      desc: "A quality watch is at least made of Stainless Steel.",
      imageUrl: "https://i.ebayimg.com/images/g/vpcAAOSwbRxc5aVt/s-l800.webp",
      isFav: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Venue"),
        centerTitle: true,
      ),
      body: GridView.builder(
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
      ),
    );
  }
}
