import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/products/cm_delete_product.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/md_product.dart';

class WdProduct extends HookWidget {
  const WdProduct({
    super.key,
    required this.product,
    required this.onDismiss,
  });

  final Product product;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    var _cmDeleteProduct = useCallAsync(cmDeleteProduct);

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              size: 40,
              color: Colors.white,
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          _cmDeleteProduct.call(product.id!);
          onDismiss();
        }
      },
      confirmDismiss: (_) async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Are you sure you want to delete ${product.title}?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Lets go!'),
                )
              ],
            );
          },
        );

        return confirmed;
      },
      child: _cmDeleteProduct.running
          ? const CircularProgressIndicator()
          : Container(
              padding: const EdgeInsets.all(15),
              child: Text(product.title!),
            ),
    );
  }
}
