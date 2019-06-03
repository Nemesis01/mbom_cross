import 'package:flutter/foundation.dart';

enum Category {
  ALL,
  SMARTPHONES,
  TABLETS,
  ACCESSORIES,
  CART,
  FAVOURITES,
  INBOX,
  SETTINGS,
  ABOUT,
  MY_ACCOUNT,
}

class Product {
  // MEMBERS
  final String id;
  final Category category;
  final String name;
  final String shortDescription;
  final String description;
  final int price;

  // CONSTRUCTOR(S)
  const Product({
    @required this.id,
    @required this.category,
    @required this.name,
    @required this.price,
    this.description,
    this.shortDescription,
  })  : assert(id != null),
        assert(category != null),
        assert(name != null),
        assert(price != null);

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        category = json['category'],
        name = json['name'],
        shortDescription = json['shortDescription'],
        description = json['description'],
        price = json['price'];

  // GETTER(S) AND SETTER(S)

  @override
  String toString() {
    return this.name;
  }

  //****************************************************************************
  //
  // FUNCTION(S)
  //
  //****************************************************************************

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'name': name,
        'description': description,
        'price': price,
      };
}
