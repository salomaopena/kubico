import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubico/models/cart_product/cart_product.dart';
import 'package:kubico/screens/product_details/product_detail_screen.dart';
import 'package:kubico/utils/theme.dart';

class OrderProductTile extends StatelessWidget {
  const OrderProductTile({required this.producCart});

  final CartProduct producCart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(ProductDetailScreen(product: producCart.product)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(producCart.product.images.first,
                  fit: BoxFit.fill),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producCart.product.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tamanho: ${producCart.size}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'AOA ${(producCart.fixedPrice ?? producCart.unityPrice).toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.pink),
                  ),
                ],
              ),
            ),
            Text(
              '${producCart.quantity}x',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
