import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/product/product_manager.dart';
import 'package:kubico/screens/cart/cart_screen.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:kubico/screens/product/components/search_dialog.dart';
import 'package:kubico/screens/product_details/product_detail_screen.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return Text(
                  'Produtos',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.pink,
                    fontWeight: FontWeight.w700,
                  ),
                );
              } else {
                return LayoutBuilder(builder: (_, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(productManager.search));
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    child: Container(
                        width: constraints.biggest.width,
                        child: Text(
                          productManager.search,
                          textAlign: TextAlign.center,
                        )),
                  );
                });
              }
            },
          ),
          centerTitle: true,
          actions: [
            Consumer<ProductManager>(builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.pink,
                  ),
                  onPressed: () async {
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(productManager.search));
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.pink,
                  ),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
            }),
          ],
        ),
        body: Consumer<ProductManager>(builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;

          if (filteredProducts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.pink),
                backgroundColor: Colors.transparent,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    if (product != null) {
                      final productFound =
                      productManager.findProductById(product.id as String);
                      if (productFound != null) {
                        Get.to(() => ProductDetailScreen(
                          product: productFound,
                        ));
                      }
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: product.images.first,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (_, __,
                                      DownloadProgress downloadProgress) =>
                                      Center(
                                          child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            valueColor: const AlwaysStoppedAnimation(
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
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  color: AppColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'A partir de',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  color: Colors.grey[700], fontSize: 11),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'AOA ${product.basePrice.toStringAsFixed(2)}',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index.isEven ? 2.5 : 1.7),
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Colors.pink,
          onPressed: () {
            Get.to(() => CartScreen());
          },
          child: const Icon(
            Icons.shopping_cart,
            size: 32,
          ),
        ),
      ),
    );
  }
}
