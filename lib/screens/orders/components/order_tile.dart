import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kubico/models/orders/order.dart';
import 'package:kubico/screens/orders/components/order_prodcut_tile.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.pink),
                ),
                SizedBox(height: 4),
                Text(
                  'AOA ${order.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Text(
              'Em transporte',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.pink),
            )
          ],
        ),
        children: [
          Column(
              children: order.items.map((productCart) {
            return OrderProductTile(producCart: productCart);
          }).toList())
        ],
      ),
    );
  }
}
