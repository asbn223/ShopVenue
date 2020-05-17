import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopvenue_app/models/product.dart';
import 'package:shopvenue_app/provider/product_provider.dart';

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
  final _form = GlobalKey<FormState>();
  bool _isInit = true;

  var _editProduct = Product(
    id: null,
    name: "",
    price: 0,
    desc: "",
    imageUrl: "",
  );

  var initValue = {
    'name': "",
    'price': "",
    'desc': "",
    'imageUrl': "",
  };

  @override
  void initState() {
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
    super.dispose();
    _priceFocusNode.dispose();
    _descNode.dispose();
    _imageUrlNode.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    Navigator.pop(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final String productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        _editProduct = Provider.of<Products>(context).findById(productId);
        initValue = {
          'name': _editProduct.name,
          'price': _editProduct.price.toString(),
          'desc': _editProduct.desc,
          'imageUrl': _editProduct.imageUrl,
        };
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Products"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _saveForm();
              }),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: initValue['name'],
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Product Name is empty';
                  }
//                  if (double.tryParse(value) != null) {
//                    return 'Product Name must be in numeric format';
//                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      id: _editProduct.id,
                      name: value.trim(),
                      desc: _editProduct.desc,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: initValue['price'],
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descNode);
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Product Price is empty';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Product Price must be in numeric format';
                  }
                  if (double.parse(value) <= 0) {
                    return "Product Price should not be less than zero";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      id: _editProduct.id,
                      name: _editProduct.name,
                      desc: _editProduct.desc,
                      price: double.parse(value),
                      imageUrl: _editProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: initValue['desc'],
                decoration: InputDecoration(labelText: "Description"),
                focusNode: _descNode,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Product Desc is empty';
                  }
//                  if (double.tryParse(value) != null) {
//                    return 'Product Desc must not be in numeric format';
//                  }
                  if (value.length < 10) {
                    return "Product Desc should be more than ten words";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      id: _editProduct.id,
                      name: _editProduct.name,
                      desc: value.trim(),
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl);
                },
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
//                      initialValue: initValue['imageUrl'],
                      decoration: InputDecoration(labelText: "Image Url"),
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlNode,
                      controller: _imageUrlController,
//                        ..addListener(updateImageUrl),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Image Url is empty';
                        }
//                        if (double.tryParse(value) != null) {
//                          return 'Image Url must not be in numeric format';
//                        }
                        if (!value.toLowerCase().startsWith("http") &&
                            !value.toLowerCase().startsWith('https')) {
                          return "Image Url value is not valid";
                        }
                        if (!value.toLowerCase().endsWith('.png') &&
                            !value.toLowerCase().endsWith('.jpg') &&
                            !value.toLowerCase().endsWith('.jpeg')) {
                          return 'Image format is not valid';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editProduct = Product(
                            id: _editProduct.id,
                            name: _editProduct.name,
                            desc: _editProduct.desc,
                            price: _editProduct.price,
                            imageUrl: value.trim());
                      },
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
