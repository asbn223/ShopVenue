import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/helper/custom_route.dart';
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

void main() => runApp(SplashClass());

class SplashClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
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
        ChangeNotifierProvider(create: (_) => Cart()),
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
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          home: SplashBetween(),
          routes: {
            AuthScreen.routeName: (context) => AuthScreen(),
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

class SplashBetween extends StatefulWidget {
  @override
  _SplashBetweenState createState() => _SplashBetweenState();
}

class _SplashBetweenState extends State<SplashBetween> {
  bool isInit = true;
  bool isLoggedIn = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      checkLogin();
    }
    isInit = false;
  }

  void checkLogin() async {
    isLoggedIn = await Provider.of<Auth>(context, listen: false).autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen.navigate(
        name: 'assets/Trim.flr',
        backgroundColor: Colors.blueGrey,
        startAnimation: 'Untitled',
        loopAnimation: 'Untitled',
        until: () => Future.delayed(
          Duration(seconds: 3),
        ),
        fit: BoxFit.cover,
        alignment: Alignment.center,
        next: (_) => isLoggedIn ? ProductOverViewScreen() : AuthScreen(),
      ),
    );
  }
}
