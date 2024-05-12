import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/products/domain/cm_create_product.dart';
import 'package:flutter_test_template/products/data/models/product.dart';

abstract class ProductsApi {
  Future<(BasicApiFailure?, ProductsList?)> getProducts();
  Future<(BasicApiFailure?, Product?)> createProduct(ProductDTO productParams);
  Future<(BasicApiFailure?, Product?)> updateProduct(Product product);
  Future<(BasicApiFailure?, bool?)> deleteProduct(int productId);
}
