import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/orders/order.dart';
import 'package:kubico/screens/orders/components/order_prodcut_tile.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Pedido confirmado',
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.pink,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actionsIconTheme: const IconThemeData.fallback(),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          elevation: 0,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.formattedId,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.pink),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'AOA ${order.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Column(
                  children: order.items.map((productCart) {
                return OrderProductTile(producCart: productCart);
              }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
