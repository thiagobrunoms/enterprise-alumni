import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/auth/domain/cm_do_logout.dart';
import 'package:flutter_test_template/products/domain/cm_get_products.dart';
import 'package:flutter_test_template/products/presentation/products_navigation.dart';
import 'package:flutter_test_template/products/presentation/vw_create_update_product.dart';
import 'package:flutter_test_template/products/presentation/wd_product.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';

import '../data/models/product.dart';

class VwProducts extends HookWidget {
  const VwProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var useProductsState = useState<List<Product>>([]);
    var cmGetProductsResult = useAsync(() async => await cmGetProducts(), []);
    var _cmDoLogout = useCallAsync(cmDoLogout);

    useEffect(() {
      useProductsState.value = cmGetProductsResult.result?.products ?? [];
    }, [cmGetProductsResult.result]);

    void removeProduct(Product product) {
      useProductsState.value = [...useProductsState.value..remove(product)];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: ProductsNavigation().goToProfile,
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () => _cmDoLogout.call(NoParam()),
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
                  onDismiss: () {
                    removeProduct(product);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
