import 'package:flutter/material.dart';
import 'package:mbom/models/product.dart';
import 'package:mbom/res/strings.dart';
//import 'package:flutte';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final double imageAspectRatio;
  final String url;
  final double width;

  const ProductCard({
    Key key,
    @required this.product,
    @required this.onTap,
    @required this.width,
    this.imageAspectRatio,
    this.url,
  })  : assert(product != null),
        assert(onTap != null),
        assert(width != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: onTap,
        onDoubleTap: null,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _vignette(),
                    _name(context),
                    _price(context),
                    // _buttonBar(context),
                  ],
                ),
              ),
            ),
            // IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _vignette() {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Image.asset(
        url,
        width: width,
        height: 200,
        semanticLabel: Strings.LABEL_DEFAULT_PICTURES_SEMANTIC_LABEL,
        scale: 1.0,
      ),
    );
  }

  Widget _name(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        product.name.toUpperCase(),
        style: Theme.of(context).textTheme.display1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _price(BuildContext context) {
    // TODO: implement NumberFormat and Localization
    return RaisedButton(
      onPressed: () {},
      //icon: Icon(Icons.shopping_cart),
      child: Text('${product.price} FCFA'),
    );
  }

  Widget _buttonBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
      ],
    );
  }
}
