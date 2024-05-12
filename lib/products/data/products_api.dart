import 'package:flutter_test_template/products/domain/cm_create_product.dart';
import 'package:flutter_test_template/products/data/models/product.dart';

abstract class ProductsApi {
  Future<ProductsList> getProducts();
  Future<Product> createProduct(ProductDTO productParams);
  Future<Product> updateProduct(Product product);
  Future<bool> deleteProduct(int productId);
}
