import 'package:mbom/models/product.dart';

class Repository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product>[
      Product(
        id: 'jn;suir',
        category: Category.SMARTPHONES,
        name: 'samsung m20',
        price: 135000,
      ),
      Product(
        id: 'nlanknvjnriovr',
        category: Category.SMARTPHONES,
        name: 'Lenovo K5 Pro',
        price: 170000,
      ),
      Product(
        id: 'nlsjnbovnljst',
        category: Category.SMARTPHONES,
        name: 'Huawei Y7 Prime',
        price: 155000,
      ),
      Product(
        id: 'knoiwkeopn',
        category: Category.SMARTPHONES,
        name: 'Xiaomi Redmi Note 7',
        price: 220000,
      ),
      Product(
        id: 'jn;suir',
        category: Category.SMARTPHONES,
        name: 'samsung m20',
        price: 135000,
      ),
      Product(
        id: 'noijsdljtp516',
        category: Category.SMARTPHONES,
        name: 'hotwav symbol x',
        price: 60000,
      ),
    ];
    if (category == Category.ALL) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
