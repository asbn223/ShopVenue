import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/auth_provider.dart';
import 'package:shopvenue_app/provider/order_provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';
import 'package:shopvenue_app/screens/auth_screen.dart';
import 'package:shopvenue_app/screens/cart_screen.dart';
import 'package:shopvenue_app/screens/edit_product_screen.dart';
import 'package:shopvenue_app/screens/order_screen.dart';
import 'package:shopvenue_app/screens/product_detail_screen.dart';
import 'package:shopvenue_app/screens/product_overview_screen.dart';
import 'package:shopvenue_app/screens/user_product_screen.dart';

import 'provider/cart_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: MaterialApp(
        title: 'Shop Venue',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: "TradeWinds",
          textTheme: TextTheme(
            headline6: TextStyle(fontFamily: 'Oxanium'),
          ),
        ),
        home: AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          ProductOverViewScreen.routeName: (context) => ProductOverViewScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
