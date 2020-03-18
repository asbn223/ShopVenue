import 'package:flutter/material.dart';
import 'package:shopvenue_app/provider/order_provider.dart' as OI;

class OrderItem extends StatefulWidget {
  final OI.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ExpansionTile(
          title: Text("\$ ${widget.order.amount.toString()}"),
          children: widget.order.products
              .map((prod) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        prod.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${prod.quantity} X \$ ${prod.price}',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ))
              .toList()),
//      Column(
//        children: <Widget>[
//          ListTile(
//            title: Text("\$ ${widget.order.amount.toString()}"),
//            subtitle: Text(
//              DateFormat.yMMMEd().format(widget.order.dateTime),
//            ),
//            trailing: IconButton(
//              icon: Icon(
//                _isExpanded
//                    ? FontAwesomeIcons.chevronUp
//                    : FontAwesomeIcons.chevronDown,
//                size: 16,
//              ),
//              onPressed: () {
//                setState(() {
//                  _isExpanded = !_isExpanded;
//                });
//              },
//            ),
//          ),
//          if (_isExpanded)
//            Container(
//              height: min(widget.order.products.length * 20.0 + 10, 200),
//              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
//              child: ListView(
//                  children: widget.order.products
//                      .map((prod) => Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Text(
//                                prod.name,
//                                style: TextStyle(
//                                    fontSize: 16, fontWeight: FontWeight.bold),
//                              ),
//                              Text(
//                                '${prod.quantity} X \$ ${prod.price}',
//                                style:
//                                    TextStyle(fontSize: 16, color: Colors.grey),
//                              ),
//                            ],
//                          ))
//                      .toList()),
//            ),
//        ],
//      ),
    );
  }
}
