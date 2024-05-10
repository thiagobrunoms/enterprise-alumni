import 'package:flutter/material.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/md_product.dart';

class WdProduct extends StatelessWidget {
  const WdProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
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
      onDismissed: (DismissDirection direction) {
        print('Dismissed with direction $direction');
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
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(product.title!),
      ),
    );
  }
}
