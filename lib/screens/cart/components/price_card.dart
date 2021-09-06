
import 'package:flutter/material.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({this.textButton, this.onPressed});
  final String? textButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resumo do pedido',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.grey[800]
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal',
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    )),
                Text(
                  'AOA ${productPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            if (cartManager.deliveryPrice > 0.0) ...[
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Frete',
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                      )),
                  Text(
                    'AOA ${deliveryPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                      )
                  )
                ],
              ),
            ],
            const Divider(),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.pink,
                  ),
                ),
                Text(
                  'AOA ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.pink,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  primary: AppColors.white,
                  elevation: 0,
                  padding: const EdgeInsets.all(16),
                  enableFeedback: true,
                  onSurface: AppColors.white,
                  textStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  backgroundColor: AppColors.pink,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                onPressed: onPressed,
                child: Text(
                  textButton as String,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ))
          ],
        ),
      ),
    );
  }
}
