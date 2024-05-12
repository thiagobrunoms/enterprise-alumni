import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/products/domain/cm_create_product.dart';
import 'package:flutter_test_template/products/domain/cm_update_product.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';

import '../data/models/product.dart';

class VwCreateUpdateProduct extends HookWidget {
  const VwCreateUpdateProduct({super.key, this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    var productNameController = useTextEditingController();
    var productPriceController = useTextEditingController();

    var _cmCreateProduct = useCallAsync(cmCreateProduct);
    var _cmUpdateProduct = useCallAsync(cmUpdateProduct);

    if (product != null) {
      productNameController.text = product!.title!;
      productPriceController.text = product!.price.toString();
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: productNameController,
                  decoration: const InputDecoration(label: Text('Product Name')),
                ),
                TextField(
                  controller: productPriceController,
                  decoration: const InputDecoration(
                    label: Text('Product Price'),
                  ),
                ),
                const SizedBox(height: 30),
                Builder(builder: (context) {
                  if (_cmCreateProduct.running) {
                    return const CircularProgressIndicator();
                  }

                  if (_cmCreateProduct.result != null || _cmUpdateProduct.result != null) {
                    Navigator.pop(context, _cmCreateProduct.result ?? _cmUpdateProduct.result);
                  }

                  return OutlinedButton(
                      onPressed: () {
                        if (product == null) {
                          return _cmCreateProduct.call(
                            ProductDTO(
                              title: productNameController.text,
                              price: int.parse(productPriceController.text),
                            ),
                          );
                        }

                        product!.title = productNameController.text;
                        product!.price = int.parse(productPriceController.text);
                        _cmUpdateProduct.call(product!);
                      },
                      child: Text('${product == null ? 'Create' : 'Update'} Product'));
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
