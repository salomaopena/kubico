import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/category/category.dart';
import 'package:kubico/models/category/category_manager.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:kubico/screens/product/product_category.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Categoria de produto',
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.pink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Consumer<CategoryManager>(
          builder: (_, categoryManager, __) {
            final List<Category> categories = categoryManager.categories;
            return ListView.separated(
              itemCount: categories.length,
              itemBuilder: (_, index) {
                final Category category = categories[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductCategory(category: category));
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 0,
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: AspectRatio(
                          aspectRatio: 1,
                          child: CachedNetworkImage(
                            imageUrl: category.image as String,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.medium,
                            progressIndicatorBuilder:
                                (_, __, DownloadProgress downloadProgress) =>
                                    Center(
                                        child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              valueColor: const AlwaysStoppedAnimation(
                                  AppColors.pink),
                            )),
                            errorWidget: (_, __, ___) => Image.asset(
                              'images/logo.png',
                              filterQuality: FilterQuality.high,
                              isAntiAlias: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        title: Text(
                          category.name,
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, int index) => const SizedBox(height: 4),
            );
          },
        ),
      ),
    );
  }
}
