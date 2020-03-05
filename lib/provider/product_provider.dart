import 'package:flutter/material.dart';
import 'package:shopvenue_app/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _productData = [
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
      desc: "B23 High-Top Sneakers in Dior Oblique",
      imageUrl: "https://i.ebayimg.com/images/g/vpcAAOSwbRxc5aVt/s-l800.webp",
      isFav: false,
    ),
    Product(
      id: "P005",
      name: "Galaxy S10",
      price: 2500,
      desc:
          "The phone comes with a 6.10-inch touchscreen display and an aspect ratio of 19:9. Samsung Galaxy S10 is powered by a 1.9GHz octa-core Samsung Exynos 9820 processor. It comes with 8GB of RAM. The Samsung Galaxy S10 runs Android 9.0 and is powered by a 3400mAh non-removable battery.",
      imageUrl:
          "https://shop.galaxynp.com/wp-content/uploads/2019/06/SamsungGalaxyS105G-rear-1024x768.jpg",
      isFav: false,
    ),
    Product(
      id: "P006",
      name: "Shoes",
      price: 2500,
      desc: "B23 High-Top Sneaker in Gradient Blue Dior Oblique",
      imageUrl:
          "https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/cover_image_2/870x580/17f82f742ffe127f42dca9de82fb58b1/W/7/1581010860_3SH118YUN_H560_E02_ZHC.jpg",
      isFav: false,
    ),
  ];

  List<Product> get productData {
    return [..._productData]; //Needs to update SDK Version to 2.2.2
  }

  Product findById(String id) {
    return _productData.firstWhere((product) => product.id == id);
  }
}
