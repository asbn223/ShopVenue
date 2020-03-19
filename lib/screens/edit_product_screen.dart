import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit_product_screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
//  To focus textField
  final _priceFocusNode = FocusNode();
  final _descNode = FocusNode();
  final _imageUrlNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageUrlController.addListener(updateImageUrl);
  }

//  To update container with image
  void updateImageUrl() {
    if (!_imageUrlNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
//    Removing focusNode from memory
    // TODO: implement dispose
    super.dispose();
    _priceFocusNode.dispose();
    _descNode.dispose();
    _imageUrlNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Products"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                focusNode: _descNode,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15.0, right: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                    width: 100.0,
                    height: 100.0,
                    child: _imageUrlController.text.isEmpty
                        ? FittedBox(child: Text("No Image"))
                        : Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Image Url"),
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlNode,
                      controller: _imageUrlController,
//                        ..addListener(updateImageUrl),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
