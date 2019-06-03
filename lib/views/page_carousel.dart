import 'package:flutter/material.dart';
import 'package:mbom/models/product.dart';

class CarouselPage extends StatelessWidget {
  final Product product;
  final Widget background;
  //final String headline;
  //final String subhead;
  final VoidCallback onTap;

  CarouselPage({
    this.product,
    this.background,
    //this.headline,
    //this.subhead,
    @required this.onTap,
  }) : //assert(headline != null),
        //assert(subhead != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      child: Container(
        color: theme.accentColor,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            background,
            Column(
              children: <Widget>[
                Text(
                  product.name,
                  style: theme.textTheme.display1.copyWith(color: Colors.white),
                ),
                Text(
                  product.shortDescription,
                  style: theme.textTheme.display2.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
