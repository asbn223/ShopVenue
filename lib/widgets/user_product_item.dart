import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopvenue_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title, imageUrl, id;

  UserProductItem({this.id, this.title, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100.0,
        child: Row(
          children: <Widget>[
            IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(FontAwesomeIcons.edit),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName,
                    arguments: id);
              },
            ),
            IconButton(
              color: Colors.red,
              icon: Icon(FontAwesomeIcons.trashAlt),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
