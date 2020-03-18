import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/order_provider.dart' show Orders;
import 'package:shopvenue_app/widgets/drawer.dart';
import 'package:shopvenue_app/widgets/order_items.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order_screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItem(orderData[index]),
        itemCount: orderData.length,
      ),
    );
  }
}
