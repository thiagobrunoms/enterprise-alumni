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
  Future<(BasicApiFailure?, ProductsList?)> getProducts() async {
    var (failure, response) = await _client.get('/products');

    if (failure != null) {
      return (failure, null);
    }

    return (null, ProductsList.fromJson(response!.data!));
  }

  @override
  Future<(BasicApiFailure?, Product?)> createProduct(ProductDTO productParams) async {
    var (failure, response) = (await _client.post(
      '/products/add',
      {
        'title': productParams.title,
        'price': productParams.price,
      },
    ));

    if (failure != null) {
      return (failure, null);
    }

    return (null, Product.fromJson(response!.data!));
  }

  @override
  Future<(BasicApiFailure?, Product?)> updateProduct(Product product) async {
    var (failure, response) = (await _client.put('/products/${product.id}', product.toJson()));

    if (failure != null) {
      return (failure, null);
    }

    return (null, Product.fromJson(response!.data!));
  }

  @override
  Future<(BasicApiFailure?, bool?)> deleteProduct(int productId) async {
    var (failure, _) = (await _client!.delete('/products/$productId'));

    if (failure != null) {
      return (failure, null);
    }

    return (null, true);
  }
}
