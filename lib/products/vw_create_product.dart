import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/auth/cm_do_login.dart';
import 'package:flutter_test_template/products/cm_create_product.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';

class VwCreateProduct extends HookWidget {
  const VwCreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var productNameController = useTextEditingController();
    var productPriceController = useTextEditingController();

    var _cmCreateProduct = useCallAsync(cmCreateProduct);

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: productNameController,
                  decoration:
                      const InputDecoration(label: Text('Product Name')),
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

                  return OutlinedButton(
                      onPressed: () {
                        _cmCreateProduct.call(CmCreateProductParams(
                            title: productNameController.text,
                            price: int.parse(productPriceController.text)));
                      },
                      child: const Text('Create Product'));
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
