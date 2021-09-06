
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/models/product/product.dart';
import 'package:kubico/models/users/user_manager.dart';
import 'package:kubico/screens/cart/cart_screen.dart';
import 'package:kubico/screens/login/login_screen.dart';
import 'package:kubico/screens/product_details/components/size_widget.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            product.name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.pink,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actionsIconTheme: IconThemeData.fallback(),
        ),
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images.map((url) {
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotBgColor: Colors.transparent,
                dotColor: AppColors.pink,
                autoplay: false,
                dotSpacing: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[800]),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'AOA ${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.pink,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800]),
                    ),
                  ),
                  Text(product.description,
                      style: TextStyle(
                        fontSize: 14,
                          color: Colors.grey[900]
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                          color: Colors.grey[800]
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.sizes.map((size) {
                      return SizeWidget(size: size);
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                        builder: (_, userManager, product, __) {
                      return TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.all(16),
                          enableFeedback: true,
                          onSurface: AppColors.primaryColor,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: EcommerceTheme.fontName
                          ),
                          backgroundColor: AppColors.pink,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                        onPressed: product.selectedSize != null
                            ? () {
                                if (userManager.isLoggedIn) {
                                  context
                                      .read<CartManager>()
                                      .addToCart(product);
                                  Get.to(() => CartScreen());
                                } else {
                                  Get.to(()=>LoginScreen());
                                }
                              }
                            : null,
                        child: !userManager.loading
                            ? Text(userManager.isLoggedIn
                                ? 'Adicionar ao carrinho'
                                : 'Entre para comprar',
                        )
                            : const Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                      );
                    }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
