import 'package:flutter/material.dart';
import 'package:mbom/models/product.dart';
import 'package:mbom/views/product_card.dart';

class ProductsGridView extends StatelessWidget {
  // MEMBERS
  final List<Product> products;
  final int columns;

  // CONSTRUCTOR(S)
  const ProductsGridView({Key key, this.products, this.columns})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(products.length - 1, (index) {
        return Material(
          child: ProductCard(
            product: products[index],
            onTap: _onTap,
            width: 50,
            url: 'assets/images/photos/IMG_000$index.JPG',
          ),
        );
      }),
    );
  }

  void _onTap() {
    return null;
  }
}
