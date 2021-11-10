import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kubico/models/cart_product/cart_product.dart';
import 'package:kubico/utils/custom_icon_button.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile({required this.cartProduct});

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CachedNetworkImage(
                  imageUrl: cartProduct.product.images.first,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  progressIndicatorBuilder: (_,
                      __,
                      DownloadProgress
                      downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            valueColor:
                            const AlwaysStoppedAnimation(
                                Colors.pink),
                          )),
                  errorWidget: (_, __, ___) => Image.asset(
                    'images/logo.png',
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.product.name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700]
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Tamanho: ${cartProduct.size}',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Consumer<CartProduct>(builder: (_, cartProduct, __) {
                        if (cartProduct.hasStock) {
                          return Text(
                            'AOA ${cartProduct.unityPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: AppColors.pink,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          );
                        } else {
                          return const Text(
                            'Sem estoque suficiente!',
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 12,
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(
                builder: (_, cartProduct, __) {
                  return Column(
                    children: [
                      CustomIconButton(
                        icon: Icons.add,
                        color: AppColors.black,
                        onTap: cartProduct.increment,
                      ),
                      Text('${cartProduct.quantity}',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500
                      ),),
                      CustomIconButton(
                        icon: Icons.remove,
                        color: cartProduct.quantity > 1
                            ? AppColors.black
                            : AppColors.red,
                        onTap: cartProduct.decrement,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
