import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/common/api/api_management.dart';
import 'package:flutter_test_template/products/domain/cm_get_products.dart';
import 'package:flutter_test_template/products/presentation/vw_create_update_product.dart';
import 'package:flutter_test_template/products/presentation/wd_product.dart';
import 'package:flutter_test_template/profile/presentation/vw_profile.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';

import '../data/models/product.dart';

class VwProducts extends HookWidget {
  const VwProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var useProductsState = useState<List<Product>>([]);
    var cmGetProductsResult = useAsync(() async => await cmGetProducts(), []);

    useEffect(() {
      useProductsState.value = cmGetProductsResult.result?.products ?? [];
    }, [cmGetProductsResult.result]);

    void removeProduct(Product product) {
      useProductsState.value.remove(product);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VwProfile()),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: api.authentication.logout, //IMPROVE AS COMMAND!
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (cmGetProductsResult.running) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (cmGetProductsResult.error != null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text('An error occurred while retrieving products list, please try again later'),
              ),
            );
          }

          if (useProductsState.value.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text('There are no products yet, please, add new products!'),
              ),
            );
          }

          return ListView.builder(
            itemCount: useProductsState.value.length,
            itemBuilder: (context, index) {
              var product = useProductsState.value[index];
              return InkWell(
                onTap: () async {
                  var newProduct = await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return VwCreateUpdateProduct(
                        product: product,
                      );
                    },
                  );

                  if (newProduct != null) {
                    useProductsState.value = [...useProductsState.value, newProduct];
                  }
                },
                child: WdProduct(
                  product: product,
                  onDismiss: () => removeProduct(product),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newProduct = await showModalBottomSheet(
            context: context,
            builder: (context) {
              return const VwCreateUpdateProduct();
            },
          );

          if (newProduct != null) {
            useProductsState.value = [...useProductsState.value, newProduct];
          }
        },
      ),
    );
  }
}
