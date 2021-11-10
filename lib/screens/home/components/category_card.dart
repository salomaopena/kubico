import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/category/category.dart';
import 'package:kubico/screens/product/product_category.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final MQuery = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: category,
      child: GestureDetector(
        onTap: () => Get.to(() => ProductCategory(category: category)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MQuery.width * 0.5,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 30,
                child: CachedNetworkImage(
                  imageUrl: category.image as String,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (_, __, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        valueColor: const AlwaysStoppedAnimation(Colors.pink),
                      )),
                  errorWidget: (context, url, error) => Image.asset(
                    'images/logo.png',
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(flex: 10, child: SizedBox(width: 10)),
              Expanded(
                flex: 60,
                child: Text(category.name,
                    style: GoogleFonts.roboto(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
