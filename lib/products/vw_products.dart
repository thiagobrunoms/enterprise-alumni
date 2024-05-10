import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/products/cm_get_products.dart';
import 'package:flutter_test_template/products/wd_product.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/md_product.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/ut_dummy_json_api.dart';

class VwProducts extends HookWidget {
  const VwProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var cmGetProductsResult = useAsync(() async => await cmGetProducts(), []);

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

          if (cmGetProductsResult.result case final productsList) {
            int? totalProducts = productsList!.products!.length;

            if (totalProducts == 0) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                      'There are no products yet! Please, add new products!'),
                ),
              );
            }

            if (productsList.products case final products) {
              return ListView.builder(
                itemCount: totalProducts,
                itemBuilder: (context, index) {
                  if (products![index] case final eachProduct) {
                    return WdProduct(product: eachProduct);
                  }
                },
              );
            }
          }
        },
      ),
    );
  }
}
