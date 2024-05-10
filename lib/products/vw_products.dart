import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/products/cm_get_products.dart';
import 'package:flutter_test_template/products/vw_create_product.dart';
import 'package:flutter_test_template/products/wd_product.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';

import '../utils/ut_dummy_json_api/md_product.dart';

class VwProducts extends HookWidget {
  const VwProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var useProductsState = useState<List<Product>>([]);
    var cmGetProductsResult = useAsync(() async => await cmGetProducts(), []);

    useEffect(() {
      useProductsState.value = cmGetProductsResult.result?.products ?? [];
    }, [cmGetProductsResult.result]);

    return Scaffold(
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
                child: Text(
                    'An error occurred while retrieving products list, please try again later'),
              ),
            );
          }

          if (useProductsState.value.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                    'There are no products yet, please, add new products!'),
              ),
            );
          }

          return ListView.builder(
            itemCount: useProductsState.value.length,
            itemBuilder: (context, index) {
              return WdProduct(product: useProductsState.value[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newProduct = await showModalBottomSheet(
            context: context,
            builder: (context) {
              return const VwCreateProduct();
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