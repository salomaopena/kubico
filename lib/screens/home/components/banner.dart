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
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Consumer<HomeManager>(builder: (_, homeManager, __) {
          final item = homeManager.allItems;
          return Carousel(
            defaultImage: Image.network(
                'https://cdn.pixabay.com/photo/2019/12/23/01/16/cream-4713579__340.jpg'),
            images: item.map((item) {
              return NetworkImage(item.image);
            }).toList(),
            boxFit: BoxFit.cover,
            dotSize: 4,
            indicatorBgPadding: 4,
            dotSpacing: 15,
            dotBgColor: Colors.transparent,
            dotColor: AppColors.pink,
            autoplay: true,
            animationCurve: Curves.fastLinearToSlowEaseIn,
            animationDuration: Duration(milliseconds: 3000),
            onImageTap: (i) {
              final product = item[i].product;
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
      ),
    );
  }
}
