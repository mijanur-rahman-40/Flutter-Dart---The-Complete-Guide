import 'package:flutter/material.dart';
import 'package:myapp/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

import '../providers/CartProvider.dart';

import '../providers/product.dart';
// import 'package:shop_app/providers/products_provider.dart';
import '../screens/products_details_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final authData = Provider.of<AuthProvider>(context, listen: false);
    // can also same thing done by Consumer without Provider
    // but it is good that wrap up with Consumer such a item that will change not for all single item

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => ProductDetailsScreen(),
            // ));
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              // arguments: id,
              arguments: product.id,
            );
          },
          child: Image.network(
            // imageUrl,
            product.imageUrl,
            fit: BoxFit.cover,
            height: 300,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          // to ensure that we are only change the isfavorite data with the help of consumer
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              focusColor: Colors.purple,
              // label: child
              onPressed: () {
                product.toggleFavoriteStatus(authData.token);
              },
            ),
            // child: Text('Never Change'),
          ),
          title: Text(
            // title,
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Added item to cart'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
