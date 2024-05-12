import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:flutter_test_template/products/domain/cm_create_product.dart';
import 'package:flutter_test_template/products/data/models/product.dart';
import 'package:flutter_test_template/products/data/products_api.dart';

class RestProductsApi implements ProductsApi {
  RestProductsApi(
    this._client,
  );

  late HttpClient _client;

  @override
  Future<ProductsList> getProducts() async {
    var response = await _client.get('/products');

    return ProductsList.fromJson(response.data!);
  }

  @override
  Future<Product> createProduct(ProductDTO productParams) async {
    var response = await _client.post(
      '/products/add',
      {
        'title': productParams.title,
        'price': productParams.price,
      },
    );

    return Product.fromJson(response.data!);
  }

  @override
  Future<Product> updateProduct(Product product) async {
    var response = await _client.put('/products/${product.id}', product.toJson());

    return Product.fromJson(response.data!);
  }

  @override
  Future<bool> deleteProduct(int productId) async {
    var response = await _client.delete('/products/$productId');

    return response.statusCode == 200;
  }
}
