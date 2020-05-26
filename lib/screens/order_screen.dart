import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/order_provider.dart' show Orders;
import 'package:shopvenue_app/widgets/drawer.dart';
import 'package:shopvenue_app/widgets/order_items.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order_screen';

  @override
  Widget build(BuildContext context) {
//    final orderData = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrderData(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapShot.error != null) {
            return Center(
              child: Text("Error Occured, Something went wrong"),
            );
          } else {
            return Consumer<Orders>(
              builder: (context, orderData, child) => ListView.builder(
                itemBuilder: (context, index) =>
                    OrderItem(orderData.orders[index]),
                itemCount: orderData.orders.length,
              ),
            );
          }
        },
      ),
    );
  }
}
