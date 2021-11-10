import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kubico/models/home/home_manager.dart';
import 'package:kubico/models/product/product_manager.dart';
import 'package:kubico/screens/product_details/product_detail_screen.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: MediaQuery.of(context).size.height * 0.23,
      child: Consumer<HomeManager>(builder: (_, homeManager, __) {
        final items = homeManager.allItems;
        if (items.isEmpty) {
          return const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.pink),
            backgroundColor: Colors.transparent,
          );
        }
        return Carousel(
          images: items.map((item) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: CachedNetworkImage(
                imageUrl: item.image,
                fit: BoxFit.cover,
                width: double.maxFinite,
                progressIndicatorBuilder: (_, __, downloadProgress) => Center(
                    child:  CircularProgressIndicator(
                      value: downloadProgress.progress,
                      valueColor: const AlwaysStoppedAnimation(Colors.pink),
                    )),
                errorWidget: (context, url, error) => Image.asset(
                  'images/logo.png',
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
          boxFit: BoxFit.cover,
          dotSize: 4,
          indicatorBgPadding: 4,
          dotSpacing: 15,
          dotBgColor: Colors.transparent,
          dotColor: AppColors.pink,
          autoplay: true,
          animationCurve: Curves.slowMiddle,
          animationDuration: Duration(milliseconds: 3000),
          onImageTap: (i) {
            final product = items[i].product;
            if (product != null) {
              final productFound =
                  context.read<ProductManager>().findProductById(product);
              if (productFound != null) {
                Get.to(() => ProductDetailScreen(product: productFound));
              }
            }
          },
        );
      }),
    );
  }
}
