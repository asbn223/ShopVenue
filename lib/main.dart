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
import 'package:shopvenue_app/screens/splash_screen.dart';
import 'package:shopvenue_app/screens/user_product_screen.dart';

import 'provider/cart_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (BuildContext context, Auth auth, Products preProducts) {
            return Products(auth.token, auth.userId,
                preProducts == null ? [] : preProducts.productData);
          },
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (BuildContext context, Auth auth, Orders preOrders) {
            return Orders(auth.token, auth.userId,
                preOrders == null ? [] : preOrders.orders);
          },
        ),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: Consumer<Auth>(builder: (context, auth, _) {
        return MaterialApp(
          title: 'Shop Venue',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: "TradeWinds",
            textTheme: TextTheme(
              headline6: TextStyle(fontFamily: 'Oxanium'),
            ),
          ),
          home: auth.isLoggedIn
              ? ProductOverViewScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (context, authResult) =>
                      authResult.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            ProductOverViewScreen.routeName: (context) =>
                ProductOverViewScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrderScreen.routeName: (context) => OrderScreen(),
            UserProductScreen.routeName: (context) => UserProductScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        );
      }),
    );
  }
}
