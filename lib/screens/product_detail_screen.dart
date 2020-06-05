import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/provider/product_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product_detail';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
//  ScrollController _scrollController;
//  bool _isScrolled = false;
//
//  @override
//  void initState() {
//    super.initState();
//    _scrollController = ScrollController()
//      ..addListener(() {
//        _listenScrollChange();
//      });
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _scrollController.dispose();
//  }
//
//  void _listenScrollChange() {
//    if (_scrollController.offset >= 48.0) {
//      setState(() {
//        _isScrolled = true;
//        print("hey");
//      });
//    } else {
//      setState(() {
//        _isScrolled = false;
//      });
//    }
//  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedProductData =
        Provider.of<Products>(context, listen: false).findById(id);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                selectedProductData.name,
              ),
              background: Hero(
                tag: 'product$id',
                child: Container(
                  height: 300.0,
                  width: double.infinity,
                  child: Image.network(
                    selectedProductData.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              Text(
                "\$ " + selectedProductData.price.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).accentColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  selectedProductData.desc,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 500.0,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
