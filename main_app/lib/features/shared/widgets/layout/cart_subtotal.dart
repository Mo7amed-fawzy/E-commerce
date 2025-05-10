import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['qty'] * e['product']['price'] as int)
        .toList();
    // calc quantaty * price
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text('Subtotal ', style: TextStyle(fontSize: 20)),
          Text(
            '\$$sum',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
