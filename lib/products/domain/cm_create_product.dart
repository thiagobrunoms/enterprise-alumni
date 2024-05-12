import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/products/data/models/product.dart';

class ProductDTO {
  final String title;
  final int price;

  ProductDTO({required this.title, required this.price});
}

Future<Product> cmCreateProduct(ProductDTO product) async => await api.products.createProduct(product);
