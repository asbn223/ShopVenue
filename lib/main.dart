import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';
import 'package:shopvenue_app/screens/product_detail_screen.dart';
import 'package:shopvenue_app/screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Products(),
      child: MaterialApp(
        title: 'Shop Venue',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: "TradeWinds",
          textTheme: TextTheme(
            title: TextStyle(fontFamily: 'Oxanium'),
          ),
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}
