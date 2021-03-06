import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/helper/custom_route.dart';
import 'package:shopvenue_app/provider/auth_provider.dart';
import 'package:shopvenue_app/screens/auth_screen.dart';
import 'package:shopvenue_app/screens/order_screen.dart';
import 'package:shopvenue_app/screens/product_overview_screen.dart';
import 'package:shopvenue_app/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Sabin Nakarmi"),
            accountEmail: Text("asbn2231@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://avatars3.githubusercontent.com/u/45443718?s=460&u=be1129bc820863c402a43389d6919ff2bd97fa04&v=4"),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.shoppingBasket),
            title: Text('Shop'),
            onTap: () => Navigator.pushReplacementNamed(
                context, ProductOverViewScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.creditCard),
            title: Text('Orders'),
            onTap: () =>
//                Navigator.pushReplacementNamed(context, OrderScreen.routeName),
                Navigator.of(context).pushReplacement(
              CustomRoute(
                builder: (context) => OrderScreen(),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.edit),
            title: Text('Manage Your Products'),
            onTap: () =>
                /*Navigator.pushReplacementNamed(
                context, UserProductScreen.routeName), */
                Navigator.of(context).pushReplacement(
              CustomRoute(
                builder: (context) => UserProductScreen(),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () async {
              Navigator.of(context).pop();
              await Provider.of<Auth>(context, listen: false).logOut();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
